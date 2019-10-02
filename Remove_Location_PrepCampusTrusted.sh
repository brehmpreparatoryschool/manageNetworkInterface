#!/bin/sh

#First we need to identify the device name for the Wi-Fi interface.

	WIFIDEVICE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Device" | awk '{print $2}'`
    WIFIINTERFACE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Hardware Port" | awk '{print $3}'`

#Now we need to remove our location and forget the SSID for the PrepSchool_Trusted Network

	/usr/sbin/networksetup -removepreferredwirelessnetwork $WIFIDEVICE PrepSchool_Trusted
	/usr/sbin/networksetup -deletelocation "On-Campus_PrepSchool"
