# java -jar jwt-generator.jar \
#  --consumer-key DSniYQenMoVD3p2fXawfaYXnsAQa \
#  --tokens-count 100 \
#  --output-file tokens.csv \
#  --key-store-file wso2carbon.jks


https://ec2-13-50-85-120.eu-north-1.compute.amazonaws.com:8243/netty/1/secured
https://ec2-13-50-85-120.eu-north-1.compute.amazonaws.com:8243/netty/1/unsecured
http://ec2-13-48-178-58.eu-north-1.compute.amazonaws.com:8080/
https://twilight-butterfly-76d6.cloudflare-rnd-eng.workers.dev:443

jmeter -n -t apim-test.jmx \
  -l results.jtl \
  -Jusers=100 \
  -JrampUpPeriod=60 \
  -Jduration=300 \
  -Jtokens=tokens.csv \
  -Jpayload=payload.json \
  -Jhost=jwt-test.hacksland.net \
  -Jport=80 \
  -Jprotocol=http \
  -Jpath=/netty/1/unsecured \
  -Jresponse_size=200


python3 analyze.py