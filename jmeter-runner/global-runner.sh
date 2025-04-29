# EU-NORTH-1 - Stockholm - JMeter-1
EC2_HOST=ec2-13-60-69-210.eu-north-1.compute.amazonaws.com

# US-EAST-1 - N. Virginia - JMeter-2 
# EC2_HOST=ec2-13-60-69-210.eu-north-1.compute.amazonaws.com

# AP-SOUTHEAST-2 - Sydney - JMeter-3
# EC2_HOST=ec2-13-60-69-210.eu-north-1.compute.amazonaws.com

# AP-SOUTH-1 - Mumbai - JMeter-4 
# EC2_HOST=ec2-13-60-69-210.eu-north-1.compute.amazonaws.com

# SA-EAST-1 - São Paulo - JMeter-5 
# EC2_HOST=ec2-13-60-69-210.eu-north-1.compute.amazonaws.com


PEM_KEY=~/.ssh/token-validation-edge.pem


# Step 1: Copy files
scp -i "$PEM_KEY" \
    tokens.csv payload.json apim-test.jmx run.sh \
    ubuntu@"$EC2_HOST":~

# Step 2: SSH and execute script
ssh -i "$PEM_KEY" \
    -o StrictHostKeyChecking=no \
    ubuntu@"$EC2_HOST" << 'EOF'
chmod +x run.sh
./run.sh
EOF

