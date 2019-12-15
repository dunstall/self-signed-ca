#!/bin/bash

csr=$1
cert=$2

# Sign the CSR to create a server certificate.
openssl ca -config intermediate/openssl.cnf \
      -extensions server_cert -days 375 -notext -md sha256 \
      -in $csr \
      -out $cert
chmod 444 $cert

# Display the certificate.
openssl x509 -noout -text -in $cert

# Verify the certificate against the certificate chain (CA bundle).
openssl verify -CAfile intermediate/ca/certs/ca-chain.cert.pem $cert
