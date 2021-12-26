#!/bin/bash

set -e

# Usage: sudo ./script.sh
# This script will install all necessary packages to compile UBoot
# and create FIT images

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

red_bold_echo "This script should be run as root"

REQS="reqs.lst"

if [ -z "${REQS}" ]; then
	red_bold_echo "[ERROR] Expected reqs.lst file in the same directory with the package list"
	exit 1
fi

blue_bold_echo "Installing the required packages ..."

DEBIAN_FRONTEND=noninteractive apt install -y $(grep -vE "^\s*#" ${REQS}.lst | tr "\n" " ")

blue_bold_echo "Done"


