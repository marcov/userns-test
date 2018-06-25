
PODMAN_OPTS_VOLUMES = \
	-v /tmp/voltest/vol-0:/mnt/vol-0 \
	-v /tmp/voltest/vol-1000:/mnt/vol-1000 \
	-v /tmp/voltest/vol-100000:/mnt/vol-100000 \
	-v /tmp/voltest/vol-101000:/mnt/vol-101000

HOST_VOLUMES = /tmp/voltest/vol-0 /tmp/voltest/vol-1000 /tmp/voltest/vol-100000 /tmp/voltest/vol-101000

PODMAN_OPTS = $(PODMAN_OPTS_VOLUMES) --rm

PODMAN_ID_MAPS = --uidmap=0:100000:1000000 --gidmap=0:100000:1000000

OUTFILE := out.txt

TGT_IMAGE_VALUES = userns-volume-create userns-volume-exist

ifneq ($(MAKECMDGOALS),clean)
  ifeq ($(filter $(TGT_IMAGE_VALUES),$(TGT_IMAGE)),)
    $(error "Invalid value of TGT_IMAGE, (should be one of $(TGT_IMAGE_VALUES))")
  endif
endif

/tmp/voltest/vol-%:
	mkdir -p $@
	$(eval UIDGID := $(shell /usr/bin/tr -cd "[:digit:]" <<< $@))
	chown $(UIDGID):$(UIDGID) $@

.DEFAULT_GOAL := all
all: $(TGT_IMAGE) $(HOST_VOLUMES)
	/usr/bin/rm -f $(OUTFILE)
	@echo "Run as root with no user NS" | tee -a $(OUTFILE)
	podman run $(PODMAN_OPTS) $< /bin/bash /runtest.sh | tee -a $(OUTFILE)
	@echo "" | tee -a $(OUTFILE)
	@echo "Run as user 1000 with no user NS" | tee -a $(OUTFILE)
	podman run --user=1000 $(PODMAN_OPTS) $< /bin/bash /runtest.sh | tee -a $(OUTFILE)
	@echo "" | tee -a $(OUTFILE)
	@echo "Run as root with user NS " | tee -a $(OUTFILE)
	podman run $(PODMAN_ID_MAPS) $(PODMAN_OPTS) $< /bin/bash /runtest.sh | tee -a $(OUTFILE)
	@echo "" | tee -a $(OUTFILE)
	@echo "Run as user 1000 with user NS " | tee -a $(OUTFILE)
	podman run --user=1000 $(PODMAN_ID_MAPS) $(PODMAN_OPTS) $< /bin/bash /runtest.sh | tee -a $(OUTFILE)
	@echo "" | tee -a $(OUTFILE)

.PHONY: $(TGT_IMAGE)
$(TGT_IMAGE):
	buildah inspect $@ &>/dev/null || buildah bud -t $@ -f Dockerfile-$@ .

clean:
	podman rmi $(TGT_IMAGE_VALUES) 2>/dev/null || echo "Images '$(TGT_IMAGE_VALUES) not found"
	/usr/bin/rm -rf $(HOST_VOLUMES)
