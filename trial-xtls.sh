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
clear
# User Trial Vless
# // Input Data
Username="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
Username="$(echo ${Username} | sed 's/ //g' | tr -d '\r' | tr -d '\r\n' )" # > // Filtering If User Type Space

# // Validate Input
if [[ $Username == "" ]]; then
    echo -e "${EROR} Please Input an Username !"
    exit 1
fi

# // Checking User already on vps or no
if [[ "$( cat /etc/xray-mini/config.json | grep -w ${Username})" == "" ]]; then
    Do=Nothing
else
    echo -e "${EROR} User ( ${YELLOW}$Username${NC} ) Already Exists !"
    exit 1
fi

# // Expired Date
Jumlah_Hari=1
exp=`date -d "$Jumlah_Hari days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
read -p "BUG TELCO  : " BUG
domain=$(cat /etc/v2ray/domain)
port=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')
uuid=$(cat /proc/sys/kernel/random/uuid)
IP=$(wget -qO- ipinfo.io/ip)


# // Input Data User Ke XRay Vless TCP XTLS
sed -i '/#XRay$/a\### '"$username $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$username""'"' /etc/xray-mini/config.json

# // Link Configration

vlesslink1="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#${username}"
vlesslink2="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct-udp443&snrx-direct&sni=${BUG}#${username}"
vlesslink3="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#${username}"
vlesslink4="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice-udp443&sni=${BUG}#${username}"


# // Restarting XRay For Vless
systemctl restart xray@vless
systemctl restart xray@vnone
systemctl restart xray-mini

# // Success
sleep 1
clear
clear && clear && clear
clear;clear;clear
echo -e "Your Trial Vless Details"
echo -e "==============================="
echo -e " Remarks             = ${Username}"
echo -e " IP                  = ${IP}"
echo -e " Address             = ${domain}"
echo -e " Port Vless WS NTLS  = ${none}"
echo -e " Port Vless WS TLS   = ${tls}"
echo -e " Port Vless XTLS     = ${port}"
echo -e " User ID             = ${uuid}"
echo -e " HTTPS Sec           = xtls"
echo -e " HTTP Sec            = websocket"
echo -e "==============================="
echo -e "     VLESS RPRX DIRECT LINK   "
echo -e '```'${vlesslink1}'```'
echo -e "==============================="
echo -e " VLESS RPRX DIRECT UDP 443 LINK "
echo -e '```'${vlesslink2}'```'
echo -e "==============================="
echo -e "      VLESS RPRX SPLICE LINK   "
echo -e '```'${vlesslink3}'```'
echo -e "==============================="
echo -e " VLESS RPRX SPLICE UDP 443 LINK "
echo -e '```'${vlesslink4}'```'
echo -e "==============================="
echo -e " Created     = ${hariini}"
echo -e " Expired     = ${exp}"
echo -e "==============================="