#!/bin/bash

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Path

Auther=legasi

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$(wget -qO- ifconfig.me/ip)

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"

# // Clear
clear
clear && clear && clear
clear;clear;clear

# // String For User Data Option
grep -c -E "^### " "/etc/xray-mini/config.json" > /tmp/jumlah-akun-xtls.txt
grep "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 4  > /tmp/akun-xtls.txt
CLIENT_NUMBER=`cat /tmp/akun-xtls.txt | wc -l` 
echo "Total Akun = $CLIENT_NUMBER" > /tmp/total-akun-xtls.txt
for((i=1; i<=$CLIENT_NUMBER; i++ ))
do
    # // user Interval Counting
    user=$(grep -E "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

    # // Counting On Simple Algoritmatika
    now=`date -d "0 days" +"%Y-%m-%d"`
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    sisa_hari=$(( (d1 - d2) / 86400 ))

    # // String For Do Task
    user=( `cat /etc/xray-mini/config.json | grep '^###' | cut -d ' ' -f 2`);
    exp="$exp"

# // Validate Use If Syntax
if [[ $sisa_hari -lt 1 ]]; then
    # // Removing Data From Server Configuration

    sed -i "/^### $user $exp/,/^},{/d" /etc/xray-mini/config.json

    # // Restarting XRay Service
    systemctl daemon-reload
    systemctl restart xray-mini
    
    # // Successfull Deleted exp Client
    echo "user : $user | exp : $exp | Deleted $now" >> /tmp/xtls-exp-deleted.txt

else
    Skip="true"
fi

# // End Function
done

# // Cleaning data

rm -rf /tmp/jumlah-akun-xtls.txt
rm -rf /tmp/akun-xtls.txt
rm -rf/tmp/total-akun-xtls.txt
