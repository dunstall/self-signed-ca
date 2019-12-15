#!/bin/bash

csr = $1
cert = $2

# TODO config

# TODO server cert
      # -in intermediate/csr/www.example.com.csr.pem \
openssl ca -config intermediate/openssl.cnf \
      -extensions server_cert -days 375 -notext -md sha256 \
      -in $csr \
      -out $cert \
chmod 444 $cert

# TODO verify
