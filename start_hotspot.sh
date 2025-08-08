#!/bin/bash

# Create the hotspot.
/usr/bin/nmcli connection add type wifi ifname wlan0 con-name cameo-hotspot autoconnect yes ssid cameo
/usr/bin/nmcli connection modify cameo-hotspot 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
/usr/bin/nmcli connection modify cameo-hotspot wifi-sec.key-mgmt wpa-psk
/usr/bin/nmcli connection modify cameo-hotspot wifi-sec.psk "<oemac>"

# Start the hotspot.
/usr/bin/nmcli connection up cameo-hotspot
