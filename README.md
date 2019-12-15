# Self Signed CA
Create a root and intermediate certificate authorities (CA) to sign client and
server certificates.

## Create root CA (self-signed)
This will first create a 4096 bit RSA private key which will prompt for a
password to protect the key (with AES256).

Next generates a CSR which prompts for the distingiushed name (DN). The root DN
and intermediate DN must have the same country name, state and organization name
(see openssl.cnf/policy\_strict).

Once created the certificate is displayed and should be checked that the details
are correct.

The root CA should only be used to sign the intermediate CA certificates not
client or server certificates (which is handled by the intermediate CAs). This
is for security as the root CA is less used and kept offline so even if an
intermediate CA is compromised the root is safe.

```
  $ sudo ./root/create.sh
```

## Create intermediate CA (signed by root CA)
The intermediate CA is used to sign client and server certificates.

This will again create a private key then prompt for the distingiushed name (DN)
for the CSR which should have the data country name, state and organization name
as the root CA.

```
  $ sudo ./intermediate/create.sh
```

This will output the CA certificate chain (CA bundle) with the root and
intermediate certificates, which is required to trust the intermediate CA out to
intermediate/ca/certs/ca-chain.cert.pem.

# Sign a certificate
To sign either a server or client certificate use:
```
  $sudo ./intermediate/sign_server.sh <CSR path> <output cert path>
```
or
```
  $sudo ./intermediate/sign_client.sh <CSR path> <output cert path>
```

Such as:
```
  $sudo ./intermediate/sign_client.sh \
      intermediate/ca/csr/www.example.com.csr.pem \
      intermediate/ca/certs/www.example.com.cert.pem
```
