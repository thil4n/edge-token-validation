java -jar app.jar \
 --consumer-key DSniYQenMoVD3p2fXawfaYXnsAQa \
 --tokens-count 10 \
 --output-file tokens.csv \
 --key-store-file wso2carbon.jks


jmeter -n -t apim-test.jmx \
  -l results.jtl \
  -Jusers=5 \
  -JrampUpPeriod=60 \
  -Jduration=300 \
  -Jtokens=tokens.csv \
  -Jpayload=payload.json \
  -Jhost=localhost \
  -Jport=8243 \
  -Jprotocol=https \
  -Jpath=/api/v1/test \
  -Jresponse_size=200
