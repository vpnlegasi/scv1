#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
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

# // Getting XRay Client Data

CLIENT_001=$(grep -c -E "^### " "/etc/xray-mini/config.json")
echo "    =================================================="
echo "               LIST VLESS CLIENT ON THIS VPS"
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

# // String For Username && Expired Date
client=$(grep "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_002}"p)
expired=$(grep "^### " "/etc/xray-mini/config.json" | cut -d ' ' -f 8 | sed -n "${CLIENT_002}"p)

# // Removing Data From Server Configuration
sed -i "/^### username : $client | expired : $expired/,/^#BELAKANG username : $client | Expired : $expired/d" /etc/xray-mini/config.json

# // Restarting XRay Service
systemctl daemon-reload
systemctl restart xray-mini


# // Clear
clear
clear && clear && clear
clear;clear;clear

# // Successfull
echo -e "${OKEY} Username ( ${YELLOW}$client${NC} ) Has Been Removed !"