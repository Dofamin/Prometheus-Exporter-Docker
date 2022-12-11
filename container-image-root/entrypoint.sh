#!/bin/bash
set -x
service ntp start

if [ "$1" == "" ];
then
$1
else
exec ./node_exporter "$@"
fi
