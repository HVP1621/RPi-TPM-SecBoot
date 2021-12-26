# RPi-TPM-SecBoot
This repository provides steps to patch U-Boot and enable TPM2.0 based *Verified Boot* and *Measured Boot*.

# Downloading and Patching U-Boot
In this section we will clone U-Boot and patch the same. The patches in the `patches/u-boot` directory will modify the FIT Image signature verification flow in U-Boot to make use of a Public Key stored in the NVRAM of TPM2.0

## Setup U-Boot repository
Clone the U-Boot repo and checkout to the `base_commit`.

```bash
# Setting Up Repo
$ git clone https://gitlab.denx.de/u-boot/u-boot.git
$ cd u-boot
$ git checkout 360e392274e # ---> Replace this commit ID with whatever is in the base_commit file
$ make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- rpi_4_defconfig
```

## Patching the U-Boot Repo
We will now apply the patches in the `patches` directory.

```bash
$ cd u-boot
$ git am -3 ../path_to_patches_dir/*.patch # ---> Apply all patches to the U-Boot repo
$ git log # ---> Check the commit history to see if all patches were successfully applied
```