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


# // Read User Data
read -p "username : " username
username="$(echo ${username} | sed 's/ //g' | tr -d '\r')"
port=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')

# // Validate Input
if [[ $username == "" ]]; then
    echo -e "${EROR} Please Input an username !"
    exit 1
fi

# // Checking User already on vps or no
if [[ "$( cat /etc/xray-mini/config.json | grep -w ${username})" == "" ]]; then
    Do=Nothing
else
    echo -e "${EROR} User ( ${YELLOW}$Username${NC} ) Already Exists !"
    exit 1
fi

# // Read Expired Date
read -p "Expired  : " exp

# // Data String
exp=`date -d "$exp" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`

# // Vless Data

domain=$( cat /root/domain)
port=$( cat /etc/xray-mini/config.json | grep -w port | awk '{print $2}' | sed 's/,//g' )
uuid=$(cat /proc/sys/kernel/random/uuid)

# // Input Data User Ke XRay Vless TCP XTLS
sed -i '/#XRay$/a\### '"username : $username | exp : $exp"'\
            },{"id": "'""$uuid""'","flow": "'xtls-rprx-direct'","email": "'""$username""'"\
#BELAKANG '"username : $username | Expired : $exp"'' /etc/xray-mini/config.json

# // Link Configration
vlesslink1="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#$username"
vlesslink2="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct-udp443&sni=${BUG}#$username"
vlesslink3="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#$username"
vlesslink4="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice-udp443&sni=${BUG}#$username"


systemctl restart xray-mini
clear

echo -e ""
echo -e "================================="
echo -e "            XRAY TCP XTLS          "
echo -e "================================="
echo -e "Remarks        : ${username}"
echo -e "HOST IP         : ${IP}"
echo -e "Domain          : ${domain}"
echo -e "port XTLS       : $port"
echo -e "id                      : ${uuid}"
echo -e "Encryption      : none"
echo -e "network           : tcp"
echo -e "================================="
echo -e " TLS VLESS DIRECT LINK"
echo -e '```'${vlesslink1}'```'
echo -e "==============================="
echo -e " TLS VLESS DIRECT UDP 443 LINK"
echo -e '```'${vlesslink2}'```'
echo -e "==============================="
echo -e " TLS VLESS SPLICE LINK"
echo -e '```'${vlesslink3}'```'
echo -e "==============================="
echo -e " TLS VLESS SPLICE UDP 443 LINK"
echo -e '```'${vlesslink4}'```'
echo -e "==============================="
echo -e " Created     = ${hariini}"
echo -e " Expired     = ${exp}"
echo -e "==============================="