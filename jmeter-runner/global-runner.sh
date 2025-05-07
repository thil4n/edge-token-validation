# EU-NORTH-1 - Stockholm - JMeter-1
# EC2_HOST=ec2-13-60-69-210.eu-north-1.compute.amazonaws.com

# US-EAST-1 - N. Virginia - JMeter-2 
# EC2_HOST=ec2-3-88-10-16.compute-1.amazonaws.com

# AP-SOUTHEAST-2 - Sydney - JMeter-3
# EC2_HOST=13.236.165.172

# AP-SOUTH-1 - Mumbai - JMeter-4 
# EC2_HOST=ec2-13-233-91-194.ap-south-1.compute.amazonaws.com

# SA-EAST-1 - São Paulo - JMeter-5 
EC2_HOST=ec2-15-228-161-74.sa-east-1.compute.amazonaws.com


PEM_KEY=~/.ssh/token-validation-edge.pem


# Step 1: Copy files
scp -i "$PEM_KEY" \
    tokens.csv payload.json apim-test.jmx run.sh analyze.py \
    ubuntu@"$EC2_HOST":~

# Step 2: SSH and execute script
ssh -i "$PEM_KEY" \
    -o StrictHostKeyChecking=no \
    ubuntu@"$EC2_HOST" << 'EOF'
sudo apt-get remove --purge jmeter -y
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.tgz
tar -xvzf apache-jmeter-5.5.tgz
sudo apt install python3-pip -y
pip install pandas --break-system-packages
chmod +x run.sh
./run.sh
EOF

