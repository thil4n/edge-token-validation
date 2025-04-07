#!/bin/bash

# Ensure you're running this as root or with sudo if needed

# Set variables
ROOT_CA_DIR="./rootCA"
CLIENT_CERT_DIR="./client"
CLIENT_IP="13.50.85.120"
DAYS_VALID=3650  # Valid for 10 years
KEY_SIZE=2048

# Create directories for storing certs and keys
mkdir -p $ROOT_CA_DIR $CLIENT_CERT_DIR

# --- Step 1: Create Root Certificate Authority (CA) ---

echo "Creating Root CA..."

# Generate Root Key
openssl genrsa -out $ROOT_CA_DIR/rootCA.key $KEY_SIZE

# Generate Root Certificate
openssl req -x509 -new -nodes -key $ROOT_CA_DIR/rootCA.key -sha256 -days $DAYS_VALID -out $ROOT_CA_DIR/rootCA.pem \
  -subj "/C=US/ST=NA/L=NA/O=Test CA/CN=Root CA"

# --- Step 2: Generate Client Certificate (for IP) ---

echo "Creating Client Certificate for IP $CLIENT_IP..."

# Generate Client Key
openssl genrsa -out $CLIENT_CERT_DIR/client.key $KEY_SIZE

# Create the CSR (Certificate Signing Request) for the client with SAN (IP address)
cat > $CLIENT_CERT_DIR/client-ext.cnf <<EOL
[ req ]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[ req_distinguished_name ]
C = US
ST = NA
L = NA
O = Test Client
CN = $CLIENT_IP

[ v3_req ]
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth
subjectAltName = @alt_names

[ alt_names ]
IP.1 = $CLIENT_IP
EOL

# Generate the CSR using the client key
openssl req -new -key $CLIENT_CERT_DIR/client.key -out $CLIENT_CERT_DIR/client.csr \
  -subj "/C=US/ST=NA/L=NA/O=Test Client/CN=$CLIENT_IP"

# Sign the Client CSR with the Root CA to generate the Client Certificate
openssl x509 -req -in $CLIENT_CERT_DIR/client.csr -CA $ROOT_CA_DIR/rootCA.pem -CAkey $ROOT_CA_DIR/rootCA.key -CAcreateserial \
  -out $CLIENT_CERT_DIR/client-cert.pem -days $DAYS_VALID -sha256 -extfile $CLIENT_CERT_DIR/client-ext.cnf -extensions v3_req

# --- Step 3: Output info for Cloudflare Worker ---

echo "Certificates and keys have been generated."

echo "Root CA (used for verification by the server):"
echo "$ROOT_CA_DIR/rootCA.pem"

echo "Client Certificate (use this in your Worker):"
echo "$CLIENT_CERT_DIR/client-cert.pem"

echo "Client Private Key (use this in your Worker):"
echo "$CLIENT_CERT_DIR/client.key"

echo "Root CA Certificate (use this for server validation, optional):"
echo "$ROOT_CA_DIR/rootCA.pem"

# --- End of script ---
