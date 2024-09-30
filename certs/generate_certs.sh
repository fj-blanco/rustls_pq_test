#!/bin/bash

# Generate CA key and certificate
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca.key -out ca.cert -subj "/CN=Test CA" -sha256

# Generate server key
openssl genrsa -out server.key 2048

# Generate server CSR
openssl req -new -key server.key -out server.csr -subj "/CN=localhost"

# Sign the server certificate with our CA
openssl x509 -req -in server.csr -CA ca.cert -CAkey ca.key -CAcreateserial -out server.cert -days 365 -sha256 -extfile <(printf "subjectAltName=DNS:localhost")

# Create the full chain
cat server.cert ca.cert > server.fullchain