#!/bin/bash
#
# This script puts the IP address of the Home Assistant host in the CoIot field for all Shelly devices on the network and reboots the device to apply it.
# Writtin by Coen Stam.
# github@theautomation.nl
#

DOMAIN="lan"
IP_SUBNET="192.168.40"
IP_START="99"
IP_END="140"

ip=$(/sbin/ip route | tail -1 | awk 'NF>1{print $NF}')
for i in $(seq ${IP_START} ${IP_END}); do
    curl -m 2 "http://${IP_SUBNET}.${i}/settings?coiot_enable=true&coiot_peer=${ip}" 2>/dev/null | jq && curl -m 2 "http://${IP_SUBNET}.${i}/reboot" 2>/dev/null | jq
done
