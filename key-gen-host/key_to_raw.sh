#!/bin/bash -e

# Usage: ./script.sh <path_to_pub_key_dir>

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

print_usage()
{
	blue_underlined_bold_echo "[USAGE] ./script.sh <path/to/key>"
}

PUB_KEY="${1}"

if [ -z "${PUB_KEY}" ]; then
	red_bold_echo "[ERROR] Please pass the public key path"
	print_usage
	exit 1
fi

PUB_KEY_NAME=$(basename "${PUB_KEY}")
PUB_KEY_DIR=$(dirname "${PUB_KEY}")

dd if="${PUB_KEY}" of="${PUB_KEY_DIR}/${PUB_KEY_NAME}.raw" bs=24 skip=1

blue_bold_echo "Raw DER format key available ${PUB_KEY_DIR}"
