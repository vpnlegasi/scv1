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
echo "This Feature Can Only Be Used According To Vps Data With This Autoscript"
echo "Please input link to your vps data backup file."
echo "You can check it on your email if you run backup data vps before."
read -rp "Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
cp passwd /etc/
cp group /etc/
cp shadow /etc/
cp gshadow /etc/
cp -r wireguard /etc/
cp chap-secrets /etc/ppp/
cp ss.conf /etc/shadowsocks-libev/ss.conf
cp -r premium-script /var/lib/
cp -r trojan /etc/
cp -r xray /usr/local/etc/
cp -r shadowsocksr /usr/local/
cp -r public_html /home/vps/
cp crontab /etc/
strt
rm -rf /root/backup
rm -f backup.zip
echo Done
