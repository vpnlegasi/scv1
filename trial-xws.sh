#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.co);
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
domain=$(cat /etc/v2ray/domain)
tls="$(cat ~/log-install.txt | grep -w "Xray Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Xray Vmess None TLS" | cut -d: -f2|sed 's/ //g')"

# User Trial Vmess
user="VPNLegasi-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
user="$(echo ${user} | sed 's/ //g' | tr -d '\r' | tr -d '\r\n' )" # > // Filtering If User Type Space

# // Validate Input
if [[ $user == "" ]]; then
    echo -e "${EROR} Please Input an user !"
    exit 1
fi

# // Checking User already on vps or no
if [[ "$( cat /usr/local/etc/xray/config.json | grep -w ${user})" == "" ]]; then
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
read -p "BUG TELCO  : " bug
domain=$(cat /etc/v2ray/domain)
port=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')
uuid=$(cat /proc/sys/kernel/random/uuid)
IP=$(wget -qO- ipinfo.io/ip)


# // Input Data User Ke XRay Vmess
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/none.json
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${WILD}${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/xray",
      "type": "none",
      "host": "$bug",
      "tls": "tls"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${WILD}${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/xray",
      "type": "none",
      "host": "$bug",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)

# // Link Configration
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

systemctl restart xray
systemctl restart xray@none
service cron restart
clear

echo -e ""
echo -e "==============================="
echo -e "       YOUR TRIAL XRAY VMESS          "
echo -e "==============================="
echo -e "Remarks       : ${user} "
echo -e "Domain        : ${domain}  "
echo -e "port TLS      : ${tls}   "
echo -e "port none TLS : ${none} "
echo -e "id            : ${uuid} "
echo -e "alterId       : 0     "
echo -e "Security      : auto  "
echo -e "network       : ws  "
echo -e "path          : /xray    "
echo -e "==============================="
echo -e "        VMESS TLS WS LINK      "
echo -e '```'${vmesslink1}'```'
echo -e "==============================="
echo -e "        VMESS NTLS WS LINK     "
echo -e '```'${vmesslink2}'```'
echo -e "==============================="
echo -e " Created : ${hariini}"
echo -e " Expired : ${exp}"
echo -e "==============================="
