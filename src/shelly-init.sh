#!/bin/bash
#
# Put the Home Assistant host ip in CoIot field for all Shelly devices in the network.
# Writtin by Coen Stam.
# github@theautomation.nl
#

set -e

DOMAIN="lan"
IP_SUBNET="192.168.40"
IP_START="99"
IP_END="140"

ip=$(hostname -I | cut -d' ' -f1)
for i in $(seq ${IP_START} ${IP_END}); do
    curl -m 2 "http://${IP_SUBNET}.${i}/settings?coiot_enable=true&coiot_peer=${ip}" 2>/dev/null | jq && curl -m 2 "http://${IP_SUBNET}.${i}/reboot" 2>/dev/null | jq
done
