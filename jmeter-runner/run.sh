#!/bin/bash

# APIM https://haxtreme.info/netty/1/unsecured
# APIM https://haxtreme.info/netty/1/secured
# CFW  https://twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev

# Define test targets

declare -a target_hosts=("haxtreme.info" "haxtreme.info" "twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev")
declare -a target_paths=("/netty/1/unsecured" "/netty/1/secured" "/")


# Loop through each target
for target_host in "${!target_hosts[@]}"; do

  # Extract the host and path for the current target
  host=${target_hosts[$target_host]}
  path=${target_paths[$target_host]}
  echo "Running test for $host$path"

  rm -f results.jtl;

  ./apache-jmeter-5.5/bin/jmeter.sh -n -t apim-test.jmx \
    -l "results.jtl" \
    -Jusers=10 \
    -JrampUpPeriod=10 \
    -Jduration=100 \
    -Jtokens=tokens.csv \
    -Jpayload=payload.json \
    -Jhost=$host \
    -Jport=443 \
    -Jprotocol=https \
    -Jpath=$path \
    -Jresponse_size=200 \
    > /dev/null 2>&1


  echo " Analyzing results for $host"
  python3 analyze.py "results.jtl"
  rm -f results.jtl;
  echo "--------------------------------------"
done
