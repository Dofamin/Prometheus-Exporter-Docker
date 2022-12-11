#!/bin/bash
set -x
service ntp start

if [ "$1" == "" ];
then
bash
else
exec ./node_exporter "$@"
fi
