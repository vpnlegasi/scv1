#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
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
echo -e "\e[0m                                                                            "
echo -e "\e[92m                     █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█                                "
echo -e "\e[92m                     █░░╦─╦╔╗╦─╔╗╔╗╔╦╗╔╗░░█                                "
echo -e "\e[92m                     █░░║║║╠─║─║─║║║║║╠─░░█                                "
echo -e "\e[92m                     █░░╚╩╝╚╝╚╝╚╝╚╝╩─╩╚╝░░█                                "
echo -e "\e[92m                     █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█                                "
echo -e "\e[0m                                                                            "
echo -e "\e[93m                      AutoScript VPN Legasi                                "
echo -e "\e[0m                                                                            "
echo -e "\e[92m ████████ ██   ██  █████  ███    ██ ██   ██ ███████     ████████  ██████   "
echo -e "\e[92m    ██    ██   ██ ██   ██ ████   ██ ██  ██  ██             ██    ██    ██  "
echo -e "\e[92m    ██    ███████ ███████ ██ ██  ██ █████   ███████        ██    ██    ██  "
echo -e "\e[92m    ██    ██   ██ ██   ██ ██  ██ ██ ██  ██       ██        ██    ██    ██  "
echo -e "\e[92m    ██    ██   ██ ██   ██ ██   ████ ██   ██ ███████        ██     ██████   "
echo -e "\e[92m                                                                           "
echo -e "\e[92m                                                                           "
echo -e "\e[92m  █████  ██      ██       █████  ██   ██     ███████ ██     ██ ████████    "
echo -e "\e[92m ██   ██ ██      ██      ██   ██ ██   ██     ██      ██     ██    ██       "
echo -e "\e[92m ███████ ██      ██      ███████ ███████     ███████ ██  █  ██    ██       "
echo -e "\e[92m ██   ██ ██      ██      ██   ██ ██   ██          ██ ██ ███ ██    ██       "
echo -e "\e[92m ██   ██ ███████ ███████ ██   ██ ██   ██     ███████  ███ ███     ██       "
echo -e "\e[0m                                                                            "
echo -e "\e[94m             ________________________________________________              "
echo -e "\e[94m            /                                                \             "
echo -e "\e[94m           |    _________________________________________     |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |  root:                                  |    |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |     LAJU-LAJU SAMPAI 500Mbps            |    |            "
echo -e "\e[94m           |   |     NAK PERGI MANA BOSKU..              |    |            "
echo -e "\e[94m           |   |     DAPAT BYPASS 10 Mbps                |    |            "
echo -e "\e[94m           |   |     PUN SYUKUR DAH JIMAT                |    |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |                                         |    |            "
echo -e "\e[94m           |   |_________________________________________|    |            "
echo -e "\e[94m           |                                                  |            "
echo -e "\e[94m            \_________________________________________________/            "
echo -e "\e[94m                   \___________________________________/                   "
echo -e "\e[93m                         Script by RARE                                    "
echo -e "\e[93m                          [1] BACK MENU                                    "
echo -e "\e[93m        .----------------------------------------------------.             "
echo -e "\e[93m        |             Script status : Premium                |             "
echo -e "\e[93m        '----------------------------------------------------'             "
read -p "               Select an option [1] than press ENTER: :  " Options
sleep 1
clear
case $Options in
		1)
		clear
		menu
		exit
		;;
	esac
