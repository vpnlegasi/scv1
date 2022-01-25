#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/vpnlegasi/ipv1.0/main/access | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users | Contact me at Telegram @vpnlegasi to Unlock"
exit 0
fi
# // Clear
clear
clear && clear && clear
clear;clear;clear

# // String For User Data Option
grep -c -E "^### " "/etc/xray-mini/config.json" > /etc/xray-mini/config.json
grep "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 4  > /etc/xray-mini/config.json
totalaccounts=`cat /etc/xray-mini/config.json | wc -l` 
echo "Total Akun = $totalaccounts" > /etc/xray-mini/config.json
for((i=1; i<=$totalaccounts; i++ ))
do
    # // Username Interval Counting
    user=`head -n $i /etc/xray-mini/config.json | tail -n 1`
    expired=$( cat /etc/xray-mini/config.json | grep -w $user | head -n1 | awk '{print $8}' )

    # // Counting On Simple Algoritmatika
    now=`date -d "0 days" +"%Y-%m-%d"`
    d1=$(date -d "$expired" +%s)
    d2=$(date -d "$now" +%s)
    sisa_hari=$(( (d1 - d2) / 86400 ))

    # // String For Do Task
    client="$user"
    expired="$expired"

# // Validate Use If Syntax
if [[ $sisa_hari -lt 1 ]]; then
    # // Removing Data From Server Configuration
    sed -i "/^### $user $exp/,/^},{/d" /etc/xray-mini/config.json

    # // Restarting XRay Service
    systemctl daemon-reload
    systemctl restart xray-mini
   
    # // Successfull Deleted Expired Client
    echo "Username : $user | Expired : $expired | Deleted $now" >> /etc/xray-mini/config.json
    echo "Username : $user | Expired : $expired | Deleted $now"

else
    Skip="true"
fi

# // End Function
done