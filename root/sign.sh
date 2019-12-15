#!/bin/bash

csr=$1
cert=$2

openssl ca -config root/openssl.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in $csr -out $cert
chmod 444 $cert

# Display the certificate.
openssl x509 -noout -text -in $cert

# Verify the certificate against the root certificate.
openssl verify -CAfile root/ca/certs/ca.cert.pem $cert
