#!/usr/bin/bash

export METOPIZER_HOME=/usr/local/share/src-common-cpp
MPHR_CONFIG_BASE=/usr/local/share/mphr_configs

mkdir /data/ccsds

fname=$1

platform_check=`echo $fname | grep METOP-C`

if [ "${platform_check}" == "" ]; then
    mphr_config=${MPHR_CONFIG_BASE}/metopb.conf
else
    mphr_config=${MPHR_CONFIG_BASE}/metopc.conf
fi

tvcdu_to_ccsds --in /data/raw/${fname} --inst --out /data/ccsds/isps
ccsds_to_l0 --in /data/ccsds/* --use-mmam /data/mmam --generate-mmam /data/mmam --outdir /data/l0 --config-mphr ${mphr_config}
