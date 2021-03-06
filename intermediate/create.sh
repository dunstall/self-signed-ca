#!/bin/bash

# Path to the intermediate CA.
base=intermediate/ca

rm -rf $base
mkdir -p $base
mkdir $base/certs $base/crl $base/csr $base/newcerts $base/private
chmod 700 $base/private
# index.txt and serial act as a database to track signed certificates.
touch $base/index.txt
echo 1000 > $base/serial

# Add CRL file.
echo 1000 > $base/crlnumber

# Create a private key.
openssl genrsa -aes256 -out $base/private/ca.key.pem 4096
chmod 400 $base/private/ca.key.pem

# Create the CSR. The CSR CN, ST and O fields must match that of the root CA.
# See openssl.cnf/policy_strict.
openssl req -config root/openssl.cnf -new -sha256 \
      -key $base/private/ca.key.pem \
      -out $base/csr/ca.csr.pem

# Sign the CSR with the root CA and verify the certificate.
./root/sign.sh $base/csr/ca.csr.pem $base/certs/ca.cert.pem

# Create the CA certificate chain (CA bundle) containing the concatenated
# intermediate and root certificates. The root certificate is required to trust
# the intermediate CA.
cat $base/certs/ca.cert.pem \
      root/ca/certs/ca.cert.pem > $base/certs/ca-chain.cert.pem
chmod 444 $base/certs/ca-chain.cert.pem
