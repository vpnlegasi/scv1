#!/bin/bash
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
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
echo -e  "$PURPLE  .-------------------------------------------------."
echo -e  "$PURPLE  |                   $yell  Domain Menu$NC                 $PURPLE|"
echo -e  "$PURPLE  '-------------------------------------------------'$NC"
echo -e "   $green 1)$NC $yell Add Subdomain Host For VPS$NC"
echo -e "   $green 2)$NC $yell Add ID Cloudflare$NC"
echo -e "   $green 3)$NC $yell Cloudflare Add-Ons$NC"
echo -e "   $green 4)$NC $yell Pointing BUG$NC"
echo -e "   $green 5)$NC $yell Renew Certificate XRAY$NC"
echo -e "   $green 6)$NC $red BACK TO MENU$NC"
echo -e ""
read -p "     Please Input Number  [1-6 or x] :  "  opt
echo -e ""
case $opt in
1) clear ; add-host ;;
2) clear ; cff ;;
3) clear ; cfd ;;
4) clear ; cfh ;;
5) clear ; certv2ray ;;
6) clear ; menu ;;
x) exit ;;
*) echo "Please enter an correct number" ;;
esac

