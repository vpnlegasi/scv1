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


# // Input
read -p "Username   : " username
read -p "Expired    : " expired
domain=$(cat /root/domain)
uuid=$(cat /proc/sys/kernel/random/uuid)
exp=`date -d "$expired days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
port=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')

# // Input Data User Ke XRay Vless TCP XTLS
sed -i '/#XRay$/a\#DEPAN '"Username : $username | Expired : $exp"'\
            },{"id": "'""$uuid""'","flow": "'xtls-rprx-direct'"\
#BELAKANG '"Username : $username | Expired : $exp"'' /etc/xray-mini/config.json

IP=$( curl -s ipinfo.io/ip )

# // Link Configration
vlesslink1="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=bug.com#${Username}"
vlesslink2="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct-udp443&sni=bug.com#${Username}"
vlesslink3="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=bug.com#${Username}"
vlesslink4="vless://${uuid}@${domain}:${port}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice-udp443&sni=bug.com#${Username}"


systemctl restart xray-mini
clear

echo -e ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "            XRAY TCP XTLS          "
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Remarks        : ${username}"
echo -e "HOST IP        : ${IP}"
echo -e "Domain         : ${domain}"
echo -e "port XTLS      : $port"
echo -e "id             : ${uuid}"
echo -e "Encryption     : none"
echo -e "network        : tcp"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " TLS VLESS DIRECT 443 LINK"
echo -e " ${vlesslink1}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " TLS VLESS DIRECT UDP 443 LINK"
echo -e " ${vlesslink2}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " TLS VLESS SPLICE 443 LINK"
echo -e " ${vlesslink3}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " TLS VLESS SPLICE UDP 443 LINK"
echo -e " ${vlesslink4}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Created        : ${hariini}"
echo -e "Expired On     : $exp"
