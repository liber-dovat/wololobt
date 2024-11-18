# Wake On Lan On Local On Bluetooth

# Description
Power on an offline PC using wakeonlan if any known bluetooth devices in the vecinity are powered on.

The original idea is to power on the PC when an bluetooth capable xbox controller is powered on, just like a _console_ would turn on with the controller.

# HD Setup
My personal setup is a raspberry pi zero W with a raspbian running the script in a screen session, connected through Ethernet to the router, the same as the PC.

## Setup bluetoothctl
(from https://approxeng.github.io/approxeng.input/bluetooth.html)

    pi@raspberrypi ~ $ sudo apt-get install bluetooth libbluetooth3 libusb-dev
    pi@raspberrypi ~ $ sudo systemctl enable bluetooth.service
    pi@raspberrypi ~ $ sudo usermod -G bluetooth -a pi

# Xbox Series X|S controller:
  - Three blinking patterns found, plus a static light pattern.

  1. [OFF_d|OFF_bt] The controller remembers last paired state. When the controller is turned on it goes straight to the last connected state and tries to pair with that device. Blinking pattern of Dongle pairing: Blink stop...
  2. [D_d|BT_bt] From this two states (pairing/paired with Dongle|Bluetooth) if you press two times the pair button it switches back between this two states. If it was in Bluetooth pairing mode it switches back to 1). Blinking pattern of BT pairing: Blink blink stop...
  3. [D|BT] In any of this two states, if you press the pair button for 3 seconds it enters pairing mode, and ties to pair with a new Dongle or Bluetooth device; in this state the controller sends bluetooth packets. Blinking pattern: Blink blink...
  5. [OFF_d|OFF_bt] If the controller is off, holding down the pair button for 3 seconds will turn on the controller in pairing mode as in 3). Blinking pattern: Blink blink...
     This is the fastest way to power on the contoller and start sending Bluetooth packets; after this you can hold again the pair button for 3 seconds and it will switch to the last connected state.

![states](https://github.com/user-attachments/assets/e78fc0be-4648-4579-9532-b8552ef62e73)
