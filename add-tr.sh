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
uuid=$(cat /etc/trojan/uuid.txt)
source /var/lib/premium-script/ipvps.conf
domain=$(cat /etc/v2ray/domain)
hariini=`date -d "0 days" +"%Y-%m-%d"`
read -p "username: " username
user=$username`</dev/urandom tr -dc X-Z0-9 | head -c4`
tr="$(cat ~/log-install.txt | grep -i "Trojan-GFW" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
                echo -e "Name : Create Trojan-GFW Account"
                echo -e "==============================="
				read -p "ISI WILD CARD DOMAIN DIAKHIRI DOT (.)/ENTER JIKA TIADA  : " WILD
				read -p "BUG TELCO: " bug
				read -p "Expired (days): " exp
				user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)
		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done

sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
exp=`date -d "$exp days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
trojanlink="trojan://${user}@${WILD}${domain}:${tr}?sni=${bug}#$username"
clear
echo -e ""
echo -e "$green Name : Trojan-GFW"
echo -e "==============================="
echo -e "Remarks        : ${username}"
echo -e "Host/IP        : ${domain}"
echo -e "port           : ${tr}"
echo -e "Key            : ${user}"
echo -e "==============================="
echo -e "          TROJAN LINK            "
echo -e '```'${trojanlink}'```'
echo -e "==============================="
echo -e "Created        : ${hariini}"
echo -e "Expired On     : $exp"
echo -e "===============================$NC"