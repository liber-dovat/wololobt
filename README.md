# Description
Power on an offline PC using wakeonlan if any known bluetooth devices in the vecinity are powered on.
The original idea is to power on the PC when an bluetooth capable xbox controller is powered on, like a _console_.

# HD Setup
My personal setup is a raspberry pi zero W with a raspbian running the script in a screen session, connected through Ethernet to the router, the same as the PC.

## Setup bluetoothctl
(from https://approxeng.github.io/approxeng.input/bluetooth.html)

    pi@raspberrypi ~ $ sudo apt-get install bluetooth libbluetooth3 libusb-dev
    pi@raspberrypi ~ $ sudo systemctl enable bluetooth.service
    pi@raspberrypi ~ $ sudo usermod -G bluetooth -a pi

# Xbox Series X|S controller:
  - Three blinking patterns found.
  - To Check: When power it on, does it connect to the last device used? 

  1. Controller turns on with the Xbox button. It scans in dongle mode by default (?). Pattern: Blink wait blink wait...
  2. Double-tap pair, and it scans in Bluetooth mode. Pattern: Blink blink wait blink blink wait... (sometimes it sends a Bluetooth packet).
  3. Press pair twice to switch back to dongle scan. Pattern: Blink wait blink wait...
  4. Holding down pair for 3 seconds enters pair mode to pair with the dongle or Bluetooth; it sends bluetooth packets.
  5. If the controller is off, holding down pair for 3 seconds will turn on the controller in unknown Bluetooth mode (blink blink blink...). Tapping pair twice will take it to step 3). Will it connect with the last paired device?

![states](https://github.com/user-attachments/assets/c77961a7-eff7-4307-91af-ef260ef6dc7e)
