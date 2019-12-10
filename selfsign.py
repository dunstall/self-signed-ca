#!/usr/bin/python3

import argparse
import subprocess

import generatekey


def selfsign(csr: str, key: str):
    cmd = "openssl x509 -req -days 365 -in {csr} -signkey {key} -out server.crt".format(csr=csr, key=key)
    subprocess.run(cmd, shell=True, check=True)


def main(args):
    if args.key:
        selfsign(args.csr, args.key)
    else:
        generatekey.generatekey(
            generatekey.DEFAULT_KEY_SIZE, generatekey.DEFAULT_KEY_PATH
        )
        selfsign(args.csr, generatekey.DEFAULT_KEY_PATH)


def parse_args():
    parser = argparse.ArgumentParser(description="Self sign CSR.")
    parser.add_argument(
        "csr", help="path to the certificate signing request (CSR)"
    )
    parser.add_argument(
        "--key",
        help="path to the private RSA key to sign the certificate "
            "(if not given creates a new key)"
    )

    return parser.parse_args()


if __name__ == "__main__":
    main(parse_args())
