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
# User Trial XRAY Vless
# // Input Data
user=VPNLegasi-`</dev/urandom tr -dc A-Z0-9 | head -c4`
user="$(echo ${user} | sed 's/ //g' | tr -d '\r' | tr -d '\r\n' )" # > // Filtering If User Type Space

# // Validate Input
if [[ $user == "" ]]; then
    echo -e "${EROR} Please Input an user !"
    exit 1
fi

# // Checking User already on vps or no
if [[ "$( cat /etc/xray-mini/config.json | grep -w ${user})" == "" ]]; then
    Do=Nothing
else
    echo -e "${EROR} User ( ${red}$user${NC} ) Already Exists !"
    exit 1
fi
# // Expired Date
Jumlah_Hari=1
exp=`date -d "$Jumlah_Hari days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
read -p "ISI WILD CARD DOMAIN DIAKHIRI DOT (.)/ENTER JIKA TIADA  : " WILD
read -p "BUG TELCO  : " BUG
domain=$(cat /etc/v2ray/domain)
port=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')
uuid=$(cat /proc/sys/kernel/random/uuid)
IP=$(wget -qO- ipinfo.io/ip)


# // Input Data User Ke XRay Vless TCP XTLS
sed -i '/#XRay$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /etc/xray-mini/config.json

# // Link Configration

vlesslink1="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#$user"
vlesslink2="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct-udp443&snrx-direct&sni=${BUG}#$user"
vlesslink3="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#$user"
vlesslink4="vless://${uuid}@${WILD}${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice-udp443&sni=${BUG}#$user"


# // Restarting XRay For Vless
systemctl restart xray-mini

# // Success
sleep 1

# // Clear
clear && clear && clear
clear

echo -e ""
echo -e "==============================="
echo -e "      YOUR TRIAL XRAY VLESS          "
echo -e "==============================="
echo -e " Remarks                : ${user}"
echo -e " IP                     : ${IP}"
echo -e " Address                : ${domain}"
echo -e " Port Vless XTLS        : ${port}"
echo -e " User ID                : ${uuid}"
echo -e " HTTPS Sec              : xtls"
echo -e "==============================="
echo -e "  VLESS RPRX DIRECT 443 LINK   "
echo -e '```'${vlesslink1}'```'
echo -e "==============================="
echo -e " VLESS RPRX DIRECT UDP 443 LINK "
echo -e '```'${vlesslink2}'```'
echo -e "==============================="
echo -e "  VLESS RPRX SPLICE 443 LINK   "
echo -e '```'${vlesslink3}'```'
echo -e "==============================="
echo -e " VLESS RPRX SPLICE UDP 443 LINK "
echo -e '```'${vlesslink4}'```'
echo -e "==============================="
echo -e " Created : ${hariini}"
echo -e " Expired : ${exp}"
echo -e "==============================="
