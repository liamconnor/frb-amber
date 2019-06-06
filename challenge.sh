#!/bin/bash

file="/data/input.fil"
nbatch=83

source challenge_sprint.sh
conf_dir="/amber_run/conf"
snrmin=5
output="/tmp/run"

amber -debug -opencl_platform ${OPENCL_PLATFORM} -opencl_device ${OPENCL_DEVICE} -device_name ${DEVICE_NAME} -sync -print -snr_standard -padding_file $conf_dir/padding.conf -zapped_channels $conf_dir/zapped_channels.conf -integration_steps $conf_dir/integration_steps.conf -integration_file $conf_dir/integration.conf -subband_dedispersion -dedispersion_stepone_file $conf_dir/dedispersion_stepone.conf -dedispersion_steptwo_file $conf_dir/dedispersion_steptwo.conf -snr_file $conf_dir/snr.conf -output $output -subbands ${SUBBANDS} -dms ${DMS} -dm_first ${DM_FIRST} -dm_step ${DM_STEP} -subbanding_dms ${SUBBANDING_DMS} -subbanding_dm_first ${SUBBANDING_DM_FIRST} -subbanding_dm_step ${SUBBANDING_DM_STEP} -threshold $snrmin -sigproc -stream -data $file -batches $nbatch -channel_bandwidth ${CHANNEL_BANDWIDTH} -min_freq ${MIN_FREQ} -channels ${CHANNELS} -samples ${SAMPLES} -sampling_time ${SAMPLING_TIME} -compact_results

# cut first row
# select columns: DM, S/N, TIME, WIDTH
cat /tmp/run.trigger | tail -n +2 | awk 'BEGIN{FS=" "} { print $8 " " $10 " " $6 " " $4 }' > /data/output
