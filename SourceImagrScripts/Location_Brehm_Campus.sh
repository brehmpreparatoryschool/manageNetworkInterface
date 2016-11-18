#!/bin/sh

#First we need to identify the device name for the Wi-Fi interface.

	WIFIDEVICE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Device" | awk '{print $2}'`
    WIFIINTERFACE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Hardware Port" | awk '{print $3}'`

#Once we've identified the current system location and the device name of the WiFi interface, we can go about creating and configuring the new location.

	echo "Off Campus location does not exist - Creating new location"
    /usr/sbin/networksetup -createlocation "Brehm-Campus"

    echo "Changing to new network location"
    /usr/sbin/networksetup -switchtolocation "Brehm-Campus"

    echo "Adding Wi-Fi network interface"
    /usr/sbin/networksetup -createnetworkservice $WIFIINTERFACE $WIFIDEVICE

    echo "remembering connected networks"
    /usr/libexec/airportd $WIFIDEVICE prefs RememberRecentNetworks=YES

    echo "Allow users to change networks"
    /usr/libexec/airportd $WIFIDEVICE prefs RequireAdminNetworkChange=YES

    echo "Allow users to turn off wifi"
    /usr/libexec/airportd $WIFIDEVICE prefs RequireAdminPowerToggle=YES

    echo "Require Admin for Ad-Hoc"
    /usr/libexec/airportd $WIFIDEVICE prefs RequireAdminIBSS=YES

    /usr/sbin/networksetup -detectnewhardware
    IFS=$'\n'
    for i in $(/usr/sbin/networksetup -listallnetworkservices | tail +2 );
        do
                # Turn off auto proxy
                /usr/sbin/networksetup -setautoproxyurl "$i" " "
                echo "Turned off auto proxy for interface $i"
                echo "setting correct DNS Server"
                networksetup -setdnsservers "$i" 10.0.65.20
        done
    unset IFS
    echo "Auto proxy for all interfaces turned off"

    echo "Changing to Brehm-Campus location"
    /usr/sbin/networksetup -switchtolocation "Brehm-Campus"