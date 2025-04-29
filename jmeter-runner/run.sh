# java -jar jwt-generator.jar \
#  --consumer-key DSniYQenMoVD3p2fXawfaYXnsAQa \
#  --tokens-count 100 \
#  --output-file tokens.csv \
#  --key-store-file wso2carbon.jks


# APIM https://haxtreme.info/netty/1/unsecured
# APIM https://haxtreme.info/netty/1/secured
# CFW  https://twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev





jmeter -n -t apim-test.jmx \
  -l results.jtl \
  -Jusers=1 \
  -JrampUpPeriod=2 \
  -Jduration=10 \
  -Jtokens=tokens.csv \
  -Jpayload=payload.json \
  -Jhost=haxtreme.info \
  -Jport=443 \
  -Jprotocol=https \
  -Jpath=/netty/1/secured \
  -Jresponse_size=200


python3 analyze.py