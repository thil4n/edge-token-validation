java -jar jwt-generator.jar \
 --consumer-key DSniYQenMoVD3p2fXawfaYXnsAQa \
 --tokens-count 10 \
 --output-file tokens.csv \
 --key-store-file wso2carbon.jks


#https://ec2-13-50-85-120.eu-north-1.compute.amazonaws.com:8243/netty/1/unsecured

jmeter -n -t apim-test.jmx \
  -l results.jtl \
  -Jusers=5 \
  -JrampUpPeriod=60 \
  -Jduration=300 \
  -Jtokens=tokens.csv \
  -Jpayload=payload.json \
  -Jhost=ec2-13-50-85-120.eu-north-1.compute.amazonaws.com \
  -Jport=8243 \
  -Jprotocol=https \
  -Jpath=/netty/1/secured \
  -Jresponse_size=200


python3 analyze.py