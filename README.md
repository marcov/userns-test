# userns-test

Some tests on user namespaces with podman.

Run `make all` to run the tests.

Results with podman version `1d9e884232c5f89a896617f056fbfcceba1dea31`:
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


Results with podman version `82a948c04ec068acb9f0d47dc0f9e3bd05b4c90c`:
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
