#!/bin/bash

exec 200>bluetooth.lock || exit 1
flock -n 200 || { echo "Lock already taken. Script is already running."; exit 1; }

while true; do

    # Edit /etc/bluetooth/main.conf
    # add: ControllerMode=le

    # Pair button alway sends bluetooth package. Then it pairs to the dongle or bluetooth device.
    # When powering on, it first pairs to dongle, and if you press two times the pair button it
    # switches to the bluetooth device and back.

    mac1="XX:XX:XX:XX:XX:XX" # series S|X Robot
    mac2="YY:YY:YY:YY:YY:YY" # Xbox Wireless Controller Bruno
    mac3="ZZ:ZZ:ZZ:ZZ:ZZ:ZZ"
    mac4="Xbox Wireless Controller"
    pc_ip_address="192.168.x.x"
    pc_mac="00:00:00:00:00:00"

    if ! ping -c 1 -n -w 0.5 "$pc_ip_address" > /dev/null; then
        echo "PC Off $pc_ip_address. If any Controller on, power on pc..."

        # Start scanning for Bluetooth devices for 5 seconds
        output=$(bluetoothctl --timeout 5 scan on)

        # Use grep to find the specific MAC addresses in the output
        is_mac1=$(echo "$output" | grep -o "$mac1")
        is_mac2=$(echo "$output" | grep -o "$mac2")
        is_mac3=$(echo "$output" | grep -o "$mac3")
        is_mac4=$(echo "$output" | grep -o "$mac4")

        if  [[ -n "$is_mac1" || -n "$is_mac2" || -n "$is_mac3" || -n "$is_mac4" ]]; then
            echo "$output"
            echo "Found one of this macs"
            echo "$mac1, $mac2, $mac3, $mac4"
            echo ""
            echo "Waking PC"
            wakeonlan $pc_mac
            sleep 10
        else
            echo "MAC addresses not found."
        fi
    else
        echo "PC on: $pc_ip_address"
        sleep 30
    fi
    sleep 5
done
exit 0
