# java -jar jwt-generator.jar \
#  --consumer-key DSniYQenMoVD3p2fXawfaYXnsAQa \
#  --tokens-count 100 \
#  --output-file tokens.csv \
#  --key-store-file wso2carbon.jks


#!/bin/bash


# APIM https://haxtreme.info/netty/1/unsecured
# APIM https://haxtreme.info/netty/1/secured
# CFW  https://twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev

# Define test targets

declare -a target_hosts=("haxtreme.info" "haxtreme.info" "twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev")
declare -a target_paths=("/netty/1/unsecured" "/netty/1/secured" "/")


# Loop through each target
for target_host in "${!target_hosts[@]}"; do

echo "--------------------------------------"
  host=${target_hosts[$target_host]}
  path=${target_paths[$target_host]}
  echo "Running test for $host$path"



  # jmeter -n -t apim-test.jmx \
  #   -l "results-${host//./_}.jtl" \
  #   -Jusers=1 \
  #   -JrampUpPeriod=2 \
  #   -Jduration=10 \
  #   -Jtokens=tokens.csv \
  #   -Jpayload=payload.json \
  #   -Jhost=$host \
  #   -Jport=443 \
  #   -Jprotocol=https \
  #   -Jpath=$path \
  #   -Jresponse_size=200

  # echo "Analyzing results for $host"
  # python3 analyze.py "results-${host//./_}.jtl"
  # echo "--------------------------------------"
done
