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
echo -e ""
echo -e ""
echo -e ""
echo -e  "$PURPLE    .-----------------------------------------------."
echo -e  "$PURPLE    |               $yell XRAY TCP XTLS MENU$NC             $PURPLE|"
echo -e  "$PURPLE    '-----------------------------------------------'$NC"
echo -e  "  $green  1)$NC $yell TRIAL XRAY TCP XTLS $NC"
echo -e  "  $green  2)$NC $yell Create XRAY TCP XTLS Account $NC"
echo -e  "  $green  3)$NC $yell Deleting XRAY TCP XTLS Account $NC"
echo -e  "  $green  4)$NC $yell Renew XRAY TCP XTLS Account  $NC"
echo -e  "  $green  5)$NC $yell Check User Login XRAY TCP XTLS $NC"
echo -e  "  $green  6)$NC $red BACK TO MENU $NC"
echo -e ""
read -p "     Select From Options [1-5 or x] :  " OPT
echo -e   ""
case $OPT in
1) clear ; trial-xtls ;;
2) clear ; add-xtls ;;
3) clear ; del-xtls ;;
4) clear ; renew-xtls ;;
5) clear ; cek-xtls ;;
6) clear ; menu ;;
x) exit ;;
*) echo "Please enter an correct number" ;;
esac