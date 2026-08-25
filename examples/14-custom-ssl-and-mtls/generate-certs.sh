#!/usr/bin/env bash
# Generate self-signed CA, Server certificate, and Client certificate for testing mTLS
mkdir -p certs && cd certs

# 1. Generate Root CA
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout client-ca.key -out client-ca.crt -subj "/CN=My-Internal-Root-CA"

# 2. Generate Server Certificate
openssl req -nodes -newkey rsa:2048 \
  -keyout server.key -out server.csr -subj "/CN=*.example.com"
openssl x509 -req -days 365 -in server.csr -CA client-ca.crt -CAkey client-ca.key -CAcreateserial -out server.crt

# 3. Generate Client Certificate for mTLS
openssl req -nodes -newkey rsa:2048 \
  -keyout client.key -out client.csr -subj "/CN=AuthorizedUser"
openssl x509 -req -days 365 -in client.csr -CA client-ca.crt -CAkey client-ca.key -CAcreateserial -out client.crt

echo "Generated: client-ca.crt, server.crt/server.key, client.crt/client.key"
