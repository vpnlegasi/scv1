#!/bin/bash
# Renew xray
# ===============

# Color
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/vpnlegasi/ipv1.0/main/access | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users | Contact me at Telegram @vpnlegasi to Unlock"
exit 0
fi
clear
CLIENT_001=$( grep -c -E "^### " "/etc/xray-mini/config.json" )
echo "    =================================================="
echo "               LIST XTLS CLIENT ON THIS VPS"
echo "    =================================================="
grep -e "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 2-8 | nl -s ') '
	until [[ ${CLIENT_002} -ge 1 && ${CLIENT_002} -le ${CLIENT_001} ]]; do
		if [[ ${CLIENT_002} == '1' ]]; then
                echo "    =================================================="
			read -rp "    Please Input an Client Number (1-${CLIENT_001}) : " CLIENT_002
		else
                echo "    =================================================="
			read -rp "    Please Input an Client Number (1-${CLIENT_001}) : " CLIENT_002
		fi
	done

# // Clear
clear
clear && clear && clear
clear;clear;clear

# // Expired Date
read -p "Expired  : " Jumlah_Hari

user=$( grep -E "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_002}"p)
exp=$( grep -E "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_002}"p)

# // Date Configration
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $Jumlah_Hari))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`

# // Input To System Configuration
sed -i "s/### : $user | Expired : $exp/### : $user | Expired : $exp4/g" /etc/xray-mini/config.json
sed -i "s/### : $user | Expired : $exp/### : $user | Expired : $exp4/g" /etc/xray-mini/config.json
clear
echo ""
echo " VLESS Account Was Successfully Renewed"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
