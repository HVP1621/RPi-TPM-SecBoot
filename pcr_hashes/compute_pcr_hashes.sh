#!/bin/bash

set -e

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

FW_BIN_DIR="${1}"

if [ -z "${FW_BIN_DIR}" ]; then
	red_bold_echo "[ERROR] Please pass a directory which contains the following FW"
	red_bold_echo "1. Boot Script"
	red_bold_echo "2. U-Boot bin"
	red_bold_echo "3. Kernel Image (kernel8.img)"
	red_bold_echo "4. Kernel Device Tree (dtb)"
	red_bold_echo "5. FIT Image"
	red_bold_echo "6. RPI 4 Config File - config.txt"
	exit 1
fi

INITIAL_PCR_VALUE="0000000000000000000000000000000000000000000000000000000000000000"

SHA256_BOOT_SCR=$(sha256sum bin/boot.scr | awk '{split($0,a," "); print a[1]}')
blue_bold_echo "BOOT Scr Hash: $SHA256_BOOT_SCR"

CON1=`echo -ne $INITIAL_PCR_VALUE; echo $SHA256_BOOT_SCR`
TEMP=$(echo $CON1 | xxd -r -p | sha256sum)
STAGE1_PCR=${TEMP::-3}

blue_underlined_bold_echo "Stage 1 PCR: Extending with Boot Script"
echo "PCR Hash: ${STAGE1_PCR}"
echo

##########################################################################

SHA256_BL=$(sha256sum bin/u-boot.bin | awk '{split($0,a," "); print a[1]}')
blue_bold_echo "U Boot Hash: $SHA256_BL"

CON2=`echo -ne $STAGE1_PCR; echo $SHA256_BL`
TEMP=$(echo $CON2 | xxd -r -p | sha256sum)
STAGE2_PCR=${TEMP::-3}

blue_underlined_bold_echo "Stage 2 PCR: Extending with Bootloader"
echo "PCR Hash: ${STAGE2_PCR}"
echo

##########################################################################

SHA256_KERNEL=$(sha256sum bin/kernel8.img | awk '{split($0,a," "); print a[1]}')
blue_bold_echo "Kernel Hash: $SHA256_KERNEL"

CON3=`echo -ne $STAGE2_PCR; echo $SHA256_KERNEL`
TEMP=$(echo $CON3 | xxd -r -p | sha256sum)
STAGE3_PCR=${TEMP::-3}

blue_underlined_bold_echo "Stage 3 PCR: Extending with Kernel"
echo "PCR Hash: ${STAGE3_PCR}"
echo

##########################################################################

SHA256_FDT=$(sha256sum bin/bcm2711-rpi-4-b.dtb | awk '{split($0,a," "); print a[1]}')
blue_bold_echo "FDT Hash: $SHA256_FDT"

CON4=`echo -ne $STAGE3_PCR; echo $SHA256_FDT`
TEMP=$(echo $CON4 | xxd -r -p | sha256sum)
STAGE4_PCR=${TEMP::-3}

blue_underlined_bold_echo "Stage 4 PCR: Extending with FDT"
echo "PCR Hash: ${STAGE4_PCR}"
echo

##########################################################################

SHA256_FIT=$(sha256sum bin/myfit.fit | awk '{split($0,a," "); print a[1]}')
blue_bold_echo "FIT Image Hash: $SHA256_FIT"

CON5=`echo -ne $STAGE4_PCR; echo $SHA256_FIT`
TEMP=$(echo $CON5 | xxd -r -p | sha256sum)
STAGE5_PCR=${TEMP::-3}

blue_underlined_bold_echo "Stage 5 PCR: Extending with FIT"
echo "PCR Hash: ${STAGE5_PCR}"
echo

##########################################################################

SHA256_CONFIG=$(sha256sum bin/config.txt | awk '{split($0,a," "); print a[1]}')
blue_bold_echo "Config Hash: $SHA256_CONFIG"

CON6=`echo -ne $STAGE5_PCR; echo $SHA256_CONFIG`
TEMP=$(echo $CON6 | xxd -r -p | sha256sum)
STAGE6_PCR=${TEMP::-3}

blue_underlined_bold_echo "Stage 6 PCR: Extending with Config"
echo "PCR Hash: ${STAGE6_PCR}"
echo


