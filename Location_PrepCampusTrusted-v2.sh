#!/bin/bash

# For all script types, returning an exit code of 0 (success) means the
# script execution completed successfully.
#
# Requirements scripts can have the following exit codes that
# influence how the Client will handle the Fileset:
#
# - 210: This exit code will cause the Fileset to be treated like the
#        installation was successful (unless another requirements script fails,)
#        but the Fileset will not be downloaded nor installed.
#
# - 220: This exit code will prevent the installation and cause the client to
#        stop retrying unless a manual action is made (verify, reinstall, etc.)
#        or the Fileset is updated.
#
# Returning any other exit code but 0 (e.g. 1 or -1) will be reported as a
# "Requirements Failure: Script" in the Client Info window and Fileset Report.
# This will also prevent the contents of the Fileset from downloading and
# installing. In this case, requirements scripts will be executed every 2
# minutes and the Fileset will be installed when they all return 0.
#
# For other types of scripts, any non-zero exit code (e.g. 1 or -1) will cause the
# Fileset installation to fail and a script failure to be reported.
#
# If the script finishes without returning an exit code, the exit code 0
# (success) is assumed by default.
#
# Add the contents of your script below:

#First we need to identify the device name for the Wi-Fi interface.

    WIFIDEVICE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Device" | awk '{print $2}'`
    WIFIINTERFACE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Hardware Port" | awk '{print $3}'`

#Once we've identified the current system location and the device name of the WiFi interface, we can go about creating and configuring the new location.

    echo "Off Campus location does not exist - Creating new location"
    /usr/sbin/networksetup -createlocation "On-Campus_PrepSchool"

    echo "Changing to new network location"
    /usr/sbin/networksetup -switchtolocation "On-Campus_PrepSchool"

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
    
    	/usr/sbin/networksetup -addpreferredwirelessnetworkatindex $WIFIDEVICE PrepSchool_Trusted 0 WPA2 ^ZhH3jcnB

    /usr/sbin/networksetup -detectnewhardware
    IFS=$'\n'
    for i in $(/usr/sbin/networksetup -listallnetworkservices | tail +2 );
        do
                # Turn off auto proxy
                /usr/sbin/networksetup -setautoproxyurl "$i" " "
	     /usr/sbin/networksetup -setautoproxystate "$i" off
                echo "Turned off auto proxy for interface $i"
                echo "setting correct DNS Server"
                networksetup -setdnsservers "$i" 10.0.65.20
        done
    unset IFS
    echo "Auto proxy for all interfaces turned off"

    echo "Changing to On-Campus_PrepSchool location"
    /usr/sbin/networksetup -switchtolocation "On-Campus_PrepSchool"

exit 0