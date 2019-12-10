#!/usr/bin/python3

import argparse
import subprocess


DEFAULT_KEY_SIZE = 2048
DEFAULT_KEY_PATH = "private.key"


def generatekey(size: int, out: str):
    """
    Generates a private RSA key with `size` bits written to `out`. This should
    be run as root since the key is private.

    If the underlying command line call fails this will throw an exception.
    """
    cmd = "openssl genrsa -out {out} {size}".format(size=size, out=out)
    subprocess.run(cmd, shell=True, check=True)


def main(args):
    generatekey(args.numbits, args.out)


def parse_args():
    parser = argparse.ArgumentParser(description="Generate an RSA private key.")
    parser.add_argument(
        "-n", "--numbits", type=int, default=DEFAULT_KEY_SIZE,
        help="size of the key (default: {})".format(DEFAULT_KEY_SIZE)
    )
    parser.add_argument(
        "-o", "--out", default=DEFAULT_KEY_PATH,
        help="output file (default: {})".format(DEFAULT_KEY_PATH)
    )

    return parser.parse_args()


if __name__ == "__main__":
    main(parse_args())
