
PODMAN_OPTS_VOLUMES = \
	-v /tmp/voltest/vol-0:/mnt/vol-0 \
	-v /tmp/voltest/vol-1k:/mnt/vol-1k \
	-v /tmp/voltest/vol-100k:/mnt/vol-100k \
	-v /tmp/voltest/vol-101k:/mnt/vol-101k

HOST_VOLUMES = /tmp/voltest/vol-0 /tmp/voltest/vol-1k /tmp/voltest/vol-100k /tmp/voltest/vol-101k

PODMAN_OPTS = $(PODMAN_OPTS_VOLUMES) --rm

PODMAN_ID_MAPS = --uidmap=0:100000:1000000 --gidmap=0:100000:1000000

OUTFILE := out.txt

TGT_IMAGE_VALUES = userns-volume-create userns-volume-exist

ifeq ($(filter $(TGT_IMAGE_VALUES),$(TGT_IMAGE)),)
  $(error "Invalid value of TGT_IMAGE, (should be one of $(TGT_IMAGE_VALUES))")
endif

/mnt/vol-0:
	mkdir -p $@
	chown 0:0 $@

/mnt/vol-1k:
	mkdir -p $@
	chown 1000:1000 $@

/mnt/vol-100k:
	mkdir -p $@
	chown 100000:100000 $@

/mnt/vol-101k:
	mkdir -p $@
	chown 101000:101000 $@

.DEFAULT_GOAL := all
all: $(TGT_IMAGE) $(HOST_VOLUMES)
	rm -f $(OUTFILE)
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

