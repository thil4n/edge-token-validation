#!/bin/bash

KEY_NAME="token-validation-edge"
PUB_KEY_PATH="$HOME/.ssh/id_ed25519.pub"
REGIONS=("us-east-1" "eu-west-1" "ap-south-1" "ap-northeast-1" "sa-east-1")

for REGION in "${REGIONS[@]}"; do
  echo "🔐 Importing key into $REGION..."
  aws ec2 import-key-pair \
    --key-name "$KEY_NAME" \
    --public-key-material fileb://$PUB_KEY_PATH \
    --region "$REGION"
done
