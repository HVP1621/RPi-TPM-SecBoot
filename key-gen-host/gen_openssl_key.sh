#!/bin/bash -e

# Usage: ./gen_openssl_key.sh <path_to_key_dir> <key_name>
# Create RSA 2048-bit key pair
# dev.key will be the private key
# dev.crt will be the public key
# Default Dir will be "key" in the same dir as the script
# Default Key name will be "dev" in the "keys" dir

blue_underlined_bold_echo()
{
	echo -e "\e[34m\e[4m\e[1m$@\e[0m"
}

blue_bold_echo()
{
	echo -e "\e[34m\e[1m$@\e[0m"
}

red_bold_echo()
{
	echo -e "\e[31m\e[1m$@\e[0m"
}

KEY_DIR="${1}"
KEY_NAME="${2}"

if [ -z "${KEY_DIR}" ]; then
	KEY_DIR="keys"
fi

if [ -z "${KEY_NAME}" ]; then
	KEY_NAME="dev"
fi

mkdir -p ${KEY_DIR}

blue_bold_echo "Creating RSA 2048-bit Key Pair"

openssl genrsa -F4 -out ${KEY_DIR}/${KEY_NAME}.key 2048

openssl req -batch -new -x509 -key ${KEY_DIR}/${KEY_NAME}.key -out ${KEY_DIR}/${KEY_NAME}.crt

blue_bold_echo "\nConverting public key to DER format: ${KEY_DIR}/${KEY_NAME}.der"

openssl rsa -in ${KEY_DIR}/${KEY_NAME}.key -pubout -out ${KEY_DIR}/${KEY_NAME}.der -outform DER

red_bold_echo "\n[CAUTION] Your private key is ${KEY_DIR}/${KEY_NAME}.key, please store it securely!!!"
