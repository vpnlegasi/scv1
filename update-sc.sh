#!/bin/bash
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
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
versi=$(cat /home/version)
if [[ $versi == 1.1 ]]; then
echo "You Have The Latest Version"
exit 0
fi
clear
echo -e "$green   =============================================$NC"
echo -e "$green                     UPDATE SCRIPT        $NC"
echo -e "$green   =============================================$NC"
sleep 5
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/vpnlegasi/scv1/main/menu.sh"
# menu ssh-ovpn
wget -O m-sshovpn "https://raw.githubusercontent.com/vpnlegasi/scv1/main/m-sshovpn.sh"
# menu wg
wget -O m-wg "https://raw.githubusercontent.com/vpnlegasi/scv1/main/m-wg.sh"
# menu ssr
wget -O m-ssr "https://raw.githubusercontent.com/vpnlegasi/scv1/main/m-ssr.sh"
# menu xray
wget -O xray-vmess "https://raw.githubusercontent.com/vpnlegasi/scv1/main/xray-vmess.sh"
wget -O xray-vless "https://raw.githubusercontent.com/vpnlegasi/scv1/main/xray-vless.sh"
wget -O xray-xtls "https://raw.githubusercontent.com/vpnlegasi/scv1/main/xray-xtls.sh"
# menu trojan
wget -O m-trojan "https://raw.githubusercontent.com/vpnlegasi/scv1/main/m-trojan.sh"
# menu system
wget -O m-system "https://raw.githubusercontent.com/vpnlegasi/scv1/main/m-system.sh"
chmod +x menu
chmod +x m-sshovpn
chmod +x m-wg
chmod +x m-ssr
chmod +x xray-vmess
chmod +x xray-vless
chmod +x xray-xtls
chmod +x m-trojan
chmod +x m-system
cd
rm /home/version
echo "1.1" > /home/version
clear
echo " Fix minor Bugs"
echo " Now You Can Change Port Of Some Services"
