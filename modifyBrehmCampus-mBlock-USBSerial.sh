#!/bin/sh

#####################################################
# Original Create Brehm Campus Script used in Imagr #
#####################################################

# #First we need to identify the device name for the Wi-Fi interface.

# 	WIFIDEVICE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Device" | awk '{print $2}'`
#     WIFIINTERFACE=`networksetup -listallhardwareports | grep --context "Wi-Fi" | grep "Hardware Port" | awk '{print $3}'`

# #Once we've identified the current system location and the device name of the WiFi interface, we can go about creating and configuring the new location.

# 	echo "Off Campus location does not exist - Creating new location"
#     /usr/sbin/networksetup -createlocation "Brehm-Campus"

#     echo "Changing to new network location"
#     /usr/sbin/networksetup -switchtolocation "Brehm-Campus"

#     echo "Adding Wi-Fi network interface"
#     /usr/sbin/networksetup -createnetworkservice $WIFIINTERFACE $WIFIDEVICE

#     echo "remembering connected networks"
#     /usr/libexec/airportd $WIFIDEVICE prefs RememberRecentNetworks=YES

#     echo "Allow users to change networks"
#     /usr/libexec/airportd $WIFIDEVICE prefs RequireAdminNetworkChange=YES

#     echo "Allow users to turn off wifi"
#     /usr/libexec/airportd $WIFIDEVICE prefs RequireAdminPowerToggle=YES

#     echo "Require Admin for Ad-Hoc"
#     /usr/libexec/airportd $WIFIDEVICE prefs RequireAdminIBSS=YES

#     /usr/sbin/networksetup -detectnewhardware
#     IFS=$'\n'
#     for i in $(/usr/sbin/networksetup -listallnetworkservices | tail +2 );
#         do
#                 # Turn off auto proxy
#                 /usr/sbin/networksetup -setautoproxyurl "$i" " "
#                 echo "Turned off auto proxy for interface $i"
#                 echo "setting correct DNS Server"
#                 networksetup -setdnsservers "$i" [DNS Server]
#         done
#     unset IFS
#     echo "Auto proxy for all interfaces turned off"

#     echo "Changing to Brehm-Campus location"
#     /usr/sbin/networksetup -switchtolocation "Brehm-Campus"

##############################################################################
# New script to modify an existing location for USB-Serial interface support #
##############################################################################

# First we need to identify if our target location exists.  
# This could function to modify the current active location.
# We want to only target our Brehm Campus location.

# *** CONTENT NEEDED TO CHECK FOR BREHM CAMPUS NETWORK LOCATION

# Development Purposes only - List all network locations - This will be removed in the final script.
/usr/sbin/networksetup -listlocations

#Now we need to crosscheck our list to determine if our target of Brehm-Campus exists.
# If -getcurrentlocation not-equals Brehm-Campus
  # then
    # -listlocation (Pipe) string matching for Brehm-Campus
    #/usr/sbin/networksetup -listlocations | grep Brehm-Campus
EXISTINGLOCATION=`/usr/sbin/networksetup -listlocations | grep Brehm-Campus`
TARGETLOCATION="Brehm-Campus" 

if [ "$EXISTINGLOCATION" == "$TARGETLOCATION" ]; 
    then
        echo "This system has the Brehm-Campus Location"
    else
        echo "This system does not have the Brehm-Campus Location"
fi


# If the location exists but not active, change to the Brehm Campus Location
#echo "Identifying current network location"
#/usr/sbin/networksetup -getcurrentlocation

#echo "Changing to Brehm-Campus network location"
#/usr/sbin/networksetup -switchtolocation "Brehm-Campus"