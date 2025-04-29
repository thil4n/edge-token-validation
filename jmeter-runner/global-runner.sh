# EU-NORTH-1 - Stockholm - JMeter-1, APIM and Netty - created - setup
# US-EAST-1 - N. Virginia - JMeter-2 - created - setup
# AP-SOUTHEAST-2 - Sydney - JMeter-3 - created 
# AP-SOUTH-1 - Mumbai - JMeter-4 - created - setup
# SA-EAST-1 - São Paulo - JMeter-5 - created - setup

scp -i ~/.ssh/token-validation-edge.pem \
    tokens.csv payload.json apim-test.jmx \
    ubuntu@ec2-13-60-69-210.eu-north-1.compute.amazonaws.com:~


ssh -i ~/.ssh/token-validation-edge.pem \
    -o StrictHostKeyChecking=no \
    ubuntu@ec2-13-60-69-210.eu-north-1.compute.amazonaws.com