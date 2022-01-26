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
legasi=Auther

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
grep -c -E "^### " "/etc/xray-mini/config.json" > /etc/${Auther}/jumlah-akun-xtls.txt
grep "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 4  > /etc/${Auther}/akun-xtls.txt
totalaccounts=`cat /etc/${Auther}/akun-xtls.txt | wc -l` 
echo "Total Akun = $totalaccounts" > /etc/${Auther}/total-akun-xtls.txt
for((i=1; i<=$totalaccounts; i++ ))
do
    # // user Interval Counting
    user=`head -n $i /etc/${Auther}/akun-xtls.txt | tail -n 1`
    exp=$( cat /etc/xray-mini/config.json | grep -w $user | head -n1 | awk '{print $8}' )

    # // Counting On Simple Algoritmatika
    now=`date -d "0 days" +"%Y-%m-%d"`
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    sisa_hari=$(( (d1 - d2) / 86400 ))

    # // String For Do Task
    client="$user"
    exp="$exp"

# // Validate Use If Syntax
if [[ $sisa_hari -lt 1 ]]; then
    # // Removing Data From Server Configuration
    sed -i "/^### $user $exp/,/^},{/d" /etc/xray-mini/config.json

    # // Restarting XRay Service
    systemctl daemon-reload
    systemctl restart xray-mini
    
    # // Successfull Deleted exp Client
    echo "user : $user | exp : $exp | Deleted $now" >> /etc/${Auther}/xtls-exp-deleted.txt
    

else
    Skip="true"
fi

# // End Function
done