# Self Signed CA
Create a send signed certificate authority (CA) to sign client and server certificates.
This is very useful for testing.

## Root CA
Create a root CA which will be self signed. This is used to sign the intermediate CA
(which will sign the server and client certificates). The root CA must not sign
server and client certificates for security as if an intermediate CA is compromised
other intermediate CAs signed by the root are still ok.

```
  $ sudo ./root/create.sh
```

This will prompt for the distinguished name (DN). The country (C), organization (O) and state (ST)
must be the same in the intermediate CAs.

## Intermediate CA
The intermediate CA, signed by the root CA, is used to sign client and server certificates.

```
  $ sudo ./intermediate/create.sh
```

This will prompt for the distinguished name (DN). The country (C), organization (O) and state (ST)
must be the same in the root CA. This command will also verify the created certificate
against the root CA.

This will output the CA certificate chain (CA bundle) with the root and
intermediate certificates to ```intermediate/ca/certs/ca-chain.cert.pem```.

# Sign a certificate
To sign either a server or client certificate from the CSR use:
```
  $sudo ./intermediate/sign_[server|client].sh <CSR path> <output cert path>
```
This will also verify the cerfificate agains the certificate chain (intermediate and root
CAs).

For example:
```
  $ sudo ./root/create.sh
  ...
  Country Name (2 letter code) []:GB
  State or Province Name []:England
  Locality Name []:England
  Organization Name []:Test Ltd
  Organizational Unit Name []:
  Common Name []:Root CA
  Email Address []:
  ...
  
  $ ./intermediate/create.sh
  ...
  Country Name (2 letter code) []:GB
  State or Province Name []:England
  Locality Name []:England
  Organization Name []:Test Ltd
  Organizational Unit Name []:
  Common Name []:CA
  Email Address []:
  ...
  
  # Create a CSR for a server certificate.
  $ openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr
  
  # Sign the CSR with the intermediate CA.
  $ ./intermediate/sign_server.sh server.csr server.cert.pem
```
