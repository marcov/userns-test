# userns-test

A very simple test on user namespaces with podman.
The test creates a container image with or without a volume path, runs a container from it and attempt to write a file at different volume path, with different user and user NS combinations. See below for more details :-)

Run:
 - `make all TGT_IMAGE=userns-volume-create` to run the test by creating the volume path with podman.
 - `make all TGT_IMAGE=userns-volume-exist` to run the test on an image with the volume path already existing.


## Volume path already set up in the image

Results with podman version `1d9e884232c5f89a896617f056fbfcceba1dea31`
```
Run as root with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 18:52 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 18:52 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 18:52 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 18:52 vol-1k
create /mnt/vol-0/foobar: 0
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0
create /mnt/vol-1k/foobar: 0

Run as user 1000 with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 18:55 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 18:55 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 18:55 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 18:55 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 1
create /mnt/vol-1k/foobar: 0

Run as root with user NS 
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 18:55 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 18:55 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 18:55 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 18:55 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0
create /mnt/vol-1k/foobar: 1

Run as user 1000 with user NS 
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 18:55 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 18:55 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 18:55 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 18:55 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 0
create /mnt/vol-1k/foobar: 1
```


Results with podman version `82a948c04ec068acb9f0d47dc0f9e3bd05b4c90c` (after commit `bb4db6d54873c05d0654ab848c09c24a76c95a73`):
```
Run as root with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 18:52 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 18:52 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 18:52 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 18:52 vol-1k
create /mnt/vol-0/foobar: 0
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0
create /mnt/vol-1k/foobar: 0

Run as user 1000 with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 18:52 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 18:52 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 18:52 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 18:52 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 1
create /mnt/vol-1k/foobar: 0

Run as root with user NS 
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 18:52 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 18:52 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 18:52 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 18:52 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0
create /mnt/vol-1k/foobar: 1

Run as user 1000 with user NS 
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 18:52 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 18:52 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 18:52 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 18:52 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 0
create /mnt/vol-1k/foobar: 1
```

## Volume path created by podman

Results with podman version `1d9e884232c5f89a896617f056fbfcceba1dea31`
```
Run as root with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 19:20 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 19:21 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 19:21 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 19:21 vol-1k
create /mnt/vol-0/foobar: 0
create /mnt/vol-1k/foobar: 0
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0

Run as user 1000 with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 19:29 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 19:29 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 19:29 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 19:29 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-1k/foobar: 0
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 1

Run as root with user NS 
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 19:29 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 19:29 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 19:29 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 19:29 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-1k/foobar: 1
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0

Run as user 1000 with user NS 
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 19:29 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 19:29 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 19:29 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 19:29 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-1k/foobar: 1
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 0

```


Results with podman version `82a948c04ec068acb9f0d47dc0f9e3bd05b4c90c` (after commit `bb4db6d54873c05d0654ab848c09c24a76c95a73`):
```
Run as root with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 19:08 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 19:08 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 19:08 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 19:08 vol-1k
create /mnt/vol-0/foobar: 0
create /mnt/vol-1k/foobar: 0
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0

Run as user 1000 with no user NS
total 0
drwxr-xr-x 1      0      0 0 Jun 22 19:20 vol-0
drwxr-xr-x 1 100000 100000 0 Jun 22 19:20 vol-100k
drwxr-xr-x 1 101000 101000 6 Jun 22 19:20 vol-101k
drwxr-xr-x 1   1000   1000 0 Jun 22 19:20 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-1k/foobar: 0
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 1

Run as root with user NS
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 19:20 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 19:20 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 19:20 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 19:21 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-1k/foobar: 1
create /mnt/vol-100k/foobar: 0
create /mnt/vol-101k/foobar: 0

Run as user 1000 with user NS
total 0
drwxr-xr-x 1 65534 65534 0 Jun 22 19:20 vol-0
drwxr-xr-x 1     0     0 0 Jun 22 19:21 vol-100k
drwxr-xr-x 1  1000  1000 6 Jun 22 19:21 vol-101k
drwxr-xr-x 1 65534 65534 0 Jun 22 19:21 vol-1k
create /mnt/vol-0/foobar: 1
create /mnt/vol-1k/foobar: 1
create /mnt/vol-100k/foobar: 1
create /mnt/vol-101k/foobar: 0
```
