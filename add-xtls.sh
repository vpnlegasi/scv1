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
# // Checking Script Expired
expired=$(cat /usr/bin/license-remaining-day.db)
expr=`date -d "$expired days" +"%Y-%m-%d"`
nows=`date +"%Y-%m-%d"`
expired_date=$(date -d "$expr" +%s)
now_date=$(date -d "$nows" +%s)
sisa_hari=$(( ($expired_date - $now_date) / 86400 ))
   if [[ $sisa_hari  -le 0 ]]; then
   echo $sisa_hari > /usr/bin/licence-remaining-day.db
   echo -e "$Lred Your License Key Expired$NC ( $sisa_hari Days )"
exit 0
else
 echo -e "$sisa_hari days remaining. Status $green[ACTIVE]$NC"
 echo $sisa_hari > /usr/bin/license-remaining-day.db
fi

clear


# // Input
port=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray-mini/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "A client with the specified name was already created, please choose another name."
      sleep 2
			exit
		fi
	done
  uuid=$(cat /proc/sys/kernel/random/uuid)
  domain=$(cat /etc/v2ray/domain)
  read -p "ISI WILD CARD DOMAIN DIAKHIRI DOT (.)/ENTER JIKA TIADA  : " WILD
  read -p "BUG TELCO  : " BUG
  read -p "Expired    : " exp
exp=`date -d "$exp days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`

# // Input Data User Ke XRay Vless TCP XTLS

sed -i '/#XRay$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /etc/xray-mini/config.json
IP=$( curl -s ipinfo.io/ip )

# // Link Configration
vlesslink1="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#$user"
vlesslink2="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct-udp443&sni=${BUG}#$user"
vlesslink3="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#$user"
vlesslink4="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice-udp443&sni=${BUG}#$user"


systemctl restart xray-mini

# // Success
sleep 1

# // Clear
clear && clear && clear
clear

echo -e ""
echo -e "==============================="
echo -e "   YOUR XRAY TCP XTLS ACCOUNT  "
echo -e "==============================="
echo -e "Remarks        : ${user}"
echo -e "HOST IP        : ${IP}"
echo -e "Domain         : ${domain}"
echo -e "port XTLS      : $port"
echo -e "id             : ${uuid}"
echo -e "Encryption     : none"
echo -e "network        : tcp"
echo -e "==============================="
echo -e "     VLESS RPRX DIRECT LINK    "
echo -e '```'${vlesslink1}'```'
echo -e "==============================="
echo -e "VLESS RPRX DIRECT UDP 443 LINK "
echo -e '```'${vlesslink2}'```'
echo -e "==============================="
echo -e "      VLESS RPRX SPLICE LINK   "
echo -e '```'${vlesslink3}'```'
echo -e "==============================="
echo -e "VLESS RPRX SPLICE UDP 443 LINK "
echo -e '```'${vlesslink4}'```'
echo -e "==============================="
echo -e " Created       : ${hariini}"
echo -e " Expired       : ${exp}"
echo -e "==============================="
