#!/bin/bash

csr = $1
cert = $2

# TODO config

# TODO server cert
      # -in intermediate/csr/www.example.com.csr.pem \
openssl ca -config intermediate/openssl.cnf \
      -extensions client_cert -days 375 -notext -md sha256 \
      -in $csr \
      -out $cert \
chmod 444 intermediate/ca/certs/www.example.com.cert.pem

# TODO verify
