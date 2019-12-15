#!/bin/bash

base=root/ca

rm -rf $base
mkdir -p $base

mkdir -p $base/certs $base/crl $base/newcerts $base/private
chmod 700 $base/private
# index.txt and serial act as a database to track signed certificates.
touch $base/index.txt
echo 1000 > $base/serial

# Create root private key encrypted with a password for security. Use a large
# key as this is used by the root only.
openssl genrsa -aes256 -out $base/private/ca.key.pem 4096
# Read only.
chmod 400 $base/private/ca.key.pem

# Create a new certificate signing request (CSR) and self signs is with the
# given key. This certificate is valid for a year and sign with SHA256 digest.
openssl req -config root/openssl.cnf \
      -key $base/private/ca.key.pem \
      -new -x509 -days 365 -sha256 -extensions v3_ca \
      -out $base/certs/ca.cert.pem
chmod 444 $base/certs/ca.cert.pem

# Verify certificate.
openssl x509 -noout -text -in $base/certs/ca.cert.pem
