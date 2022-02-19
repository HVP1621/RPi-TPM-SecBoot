# This document describes steps to set-up the RPi Root Filesystem

I prefer to use the RPi4 Headless (Lite) Image for the experiments primarily due to their small size when compared to a full-blown Raspian OS. This example does not rely on any of the GUI features, hence a lite image will suffice. 

## Downloading the Image and Flashing an SD Card

1. Download the RPi 32-bit Headless Image from here: https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-05-28/2021-05-07-raspios-buster-armhf-lite.zip

2. Use Balena-Etcher tool https://www.balena.io/etcher/ to flash this Image on an SD Card (Recommended 16GB)

## Enabling Serial Console over UART and Early Console Logs

For our usecase, serial communication is important. This is because we mainly deal with bootloader customization. The bootloader logs are printed over a UART console and all of this is before the Linux actually boots. Hence, we need to enable early console logs as well.

1. After flashing, mount the flashed filesystem on your machine (simply plugging out and plugging the SD card back in should suffice)

2. In the /boot partition of the SD Card, open the file config.txt and at the very end, add the following line:

```bash
enable_uart=1
```

3. Save and close the file

Since this is a headless image (which means there is no GUI), we will need a Serial Console to login to the RPI on Booting.

For information on Serial Setup, refer the doc SerialSetup.md
