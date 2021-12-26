#!/bin/bash -e

# Usage: ./script <path/to/bootscript>
# Generates a UImage from a raw boot script
# U-Boot requires a Boot script to be present an UImage
# The required debian package is u-boot-tools or uboot-mkimage

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

BOOT_SCR="${1}"

if [ -z "${BOOT_SCR}" ]; then
	red_bold_echo "[ERROR] Please pass the boot script txt file"
	exit 1
fi

BOOT_SCR_NAME=$(basename ${BOOT_SCR})

mkimage -A arm64 -T script -C none -n "Boot script" -d "${BOOT_SCR}" "${BOOT_SCR_NAME}.uimg"
