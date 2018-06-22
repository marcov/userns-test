#!/usr/bin/env bash

ls -n /mnt

for i in $(find /mnt -mindepth 1 -type d); do
    touch "$i/foobar" 2>/dev/null;
    echo "create $i/foobar: $?";
    /bin/rm "$i/foobar" 2>/dev/null;
done;

exit 0
