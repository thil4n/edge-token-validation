#!/bin/bash

declare -A AMIS
AMIS["us-east-1"]="ami-049d20b1abc162db0"
AMIS["eu-west-1"]="ami-0ba9cfae65a212e98"
AMIS["ap-south-1"]="ami-0e6915ae20c3f755d"
AMIS["ap-northeast-1"]="ami-0debdcf1f574ec796"
AMIS["sa-east-1"]="ami-0e096d98a6e02dd2a"

INSTANCE_TYPE="t2.micro"
KEY_NAME="token-validation-edge"
SECURITY_GROUP_NAME="default"

for REGION in "${!AMIS[@]}"; do
    echo -e "\n--- Processing region: $REGION ---"

    # Validate region
    if ! aws ec2 describe-regions --region "$REGION" --output text &> /dev/null; then
        echo "❌ Invalid region: $REGION"
        continue
    fi

    # Validate AMI
    if ! aws ec2 describe-images --image-ids "${AMIS[$REGION]}" --region "$REGION" &> /dev/null; then
        echo "❌ Invalid AMI ID: ${AMIS[$REGION]} in region $REGION"
        continue
    fi

    # Validate or create/import key pair
    if ! aws ec2 describe-key-pairs --key-names "$KEY_NAME" --region "$REGION" &> /dev/null; then
        echo "❌ Key pair '$KEY_NAME' does not exist in $REGION"
    
        # Option 2: Import an existing public key
        if [ -f ~/.ssh/id_rsa.pub ]; then
            echo "📥 Importing ~/.ssh/id_rsa.pub into $REGION..."
            aws ec2 import-key-pair \
                --key-name "$KEY_NAME" \
                --public-key-material fileb://~/.ssh/id_rsa.pub \
                --region "$REGION"
            echo "✅ Key pair '$KEY_NAME' imported to $REGION"
        else
            echo "❌ No public key (~/.ssh/id_rsa.pub) found. Cannot import key."
            continue
        fi
    fi

    # Ensure default VPC exists
    VPC_ID=$(aws ec2 describe-vpcs \
        --filters "Name=isDefault,Values=true" \
        --region "$REGION" \
        --query "Vpcs[0].VpcId" --output text 2>/dev/null)

    if [ "$VPC_ID" == "None" ] || [ -z "$VPC_ID" ]; then
        echo "🔧 Creating default VPC in $REGION..."
        aws ec2 create-default-vpc --region "$REGION"
        sleep 5
        VPC_ID=$(aws ec2 describe-vpcs \
            --filters "Name=isDefault,Values=true" \
            --region "$REGION" \
            --query "Vpcs[0].VpcId" --output text)
    fi
    echo "✅ Default VPC ID in $REGION: $VPC_ID"

    # Validate security group
    SG_ID=$(aws ec2 describe-security-groups \
        --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=$SECURITY_GROUP_NAME" \
        --region "$REGION" \
        --query "SecurityGroups[0].GroupId" --output text 2>/dev/null)

    if [ "$SG_ID" == "None" ] || [ -z "$SG_ID" ]; then
        echo "❌ Security group '$SECURITY_GROUP_NAME' not found in $REGION"
        continue
    fi

    echo "🚀 Launching EC2 in $REGION..."
    aws ec2 run-instances \
        --image-id "${AMIS[$REGION]}" \
        --count 1 \
        --instance-type "$INSTANCE_TYPE" \
        --key-name "$KEY_NAME" \
        --security-group-ids "$SG_ID" \
        --region "$REGION" \
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Project,Value=TokenValidation}]'

    echo "✅ EC2 launched in $REGION"
done
echo -e "\n--- All regions processed ---"
echo "✅ Script completed successfully."