# java -jar jwt-generator.jar \
#  --consumer-key DSniYQenMoVD3p2fXawfaYXnsAQa \
#  --tokens-count 100 \
#  --output-file tokens.csv \
#  --key-store-file wso2carbon.jks


# https://ec2-13-50-85-120.eu-north-1.compute.amazonaws.com:8243/netty/1/secured
# https://ec2-13-50-85-120.eu-north-1.compute.amazonaws.com:8243/netty/1/unsecured
# http://ec2-13-48-178-58.eu-north-1.compute.amazonaws.com:8080/
# https://twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev:443
# https://twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev


# EU-NORTH-1 - Stockholm - JMeter-1, APIM and Netty - created - setup
# US-EAST-1 - N. Virginia - JMeter-2 - created - setup
# AP-SOUTHEAST-2 - Sydney - JMeter-3 - created 
# AP-SOUTH-1 - Mumbai - JMeter-4 - created - setup
# SA-EAST-1 - São Paulo - JMeter-5 - created - setup


jmeter -n -t apim-test.jmx \
  -l results.jtl \
  -Jusers=100 \
  -JrampUpPeriod=60 \
  -Jduration=300 \
  -Jtokens=tokens.csv \
  -Jpayload=payload.json \
  -Jhost=twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev \
  -Jport=443 \
  -Jprotocol=https \
  -Jpath=/ \
  -Jresponse_size=200


python3 analyze.py