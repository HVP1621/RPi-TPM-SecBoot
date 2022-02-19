# Setting up TPM Connections with RPI 4 Model B

We will be using a TPM 2.0 compatible device. Further the TPM device should be compatible with RPI 4. The connections to the TPM will be using Jumper Wires from the 40 pin GPIO Header of RPI 4.

## Choosing the TPM

The TPM chosen for this is Infineon TPM SLB9670_Raspberry. The model name is IRIDIUM9670 TPM2.0 LINUX

## Connections

The Infineon TPM Iridium 9670 has a GPIO Pin Out which can be used to connect it directly on the 40-pin GPIO Pinout of RPI. However since we already have a Pins 6, 8 and 10 engaged in Serial Communication, we will have to think of an alternate connection scheme between the TPM and the RPI GPIO Header

Even though the Pin out on Iridium 9670 is a 26 Pin header, we do not need all the pins to be connected between the RPI and the TPM for a successful communication. Hence we will connect only the important pins between the RPI and the TPM.

### Pin connections

From RPI Side, the following pins will have to be connected to the TPM:

```bash
Pin 1
Pin 7
Pin 18
Pin 19
Pin 21
Pin 23
Pin 26
Pin 39 - Connect to GND of TPM
```

The rest of the pins have to be connected to those input of TPM, which, if the TPM had been directly placed over the GPIO pins of RPI, would have made contact with the RPI GPIOs.

The Image TPM_Pin_Config will give a cleared picture.
