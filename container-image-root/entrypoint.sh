#!/bin/bash
set -x
service ntp start

if [ ! -d /node_exporter ]; then
    mkdir /node_exporter
fi

if [ ! -d /prometheus/config ]; then
    mkdir /prometheus/config
fi

if [ ! -f /prometheus/config/prometheus.yml ]; then
    cp ./documentation/examples/prometheus.yml /prometheus/config/prometheus.yml
fi

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
