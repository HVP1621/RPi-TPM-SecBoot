# Setting Up Serial Connections between RPi-4 and Host Machine

This setup will require HW as well as SW Components.

## Hardware Setup:

The following items will be required for establishing a serial connection.

1. Jumper Wires (Female-to-Female)

2. USB to TTL UART Connector

### Connections:

We will use the Jumper wires to make a connection between RPi4 GPIO Pins and UART Connector:

1. RPI4 GPIO Pin 6 - UART Connector GND

2. RPI4 GPIO Pin 8 - UART Connector TXD

3. RPI4 GPIO Pin 10 - UART Connector RXD


## SW Setup on Host Machine

The USB UART has to be connected to Host Machine. We will need a SW to manage the serial commnication on the USB Serial Port. I use `minicom` for the same.

```bash
$ sudo apt install -y minicom
```

## Booting Up

Assuming that you have flashed the SD Card by following the steps in *RFS_Setup.md*, we can proceed to boot-up out Pi and obtain a TTY over USB serial.

1. Insert the SD card and make the UART connections

2. Plug in the USB to TTL UART connector to your laptop. In Linux dmesg logs or Windows Device Manager, you will get to know which serial port the UART connector will be accessible from.

3. Starting a serial console session
```bash
$ sudo minicom -D /dev/ttyS0 -b 115200   # The serial port might vary from system to system
``` 

Note: Please look on how to disable "Hardware Flow Control" in minicom. This is required to enable user inputs in the serial terminal

4. For now the minicom session screen will be blank. Turn on the Power Supply to the Pi and wait for logs to appear on the screen

5. The Pi will boot-up and you can login using the default pi credentials: pi, raspberry
