#!/bin/bash
set -x
service ntp start

if [ "$1" == "" ];
then
./node_exporter \
--path.procfs=/host/proc \
--path.sysfs=/host/sys \
--path.rootfs=/host \
--collector.systemd
else
exec "$1"
fi
