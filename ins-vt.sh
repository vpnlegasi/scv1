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
domain=$(cat /root/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
chronyc sourcestats -v
chronyc tracking -v
date

mkdir -p /etc/trojan/
touch /etc/trojan/akun.conf
# install v2ray
bash -c "$(wget -O- https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"
mkdir /root/.acme.sh
curl https://get.acme.sh | sh -s email=ovpnlegasi@gmail.com
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh  --upgrade  --auto-upgrade
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
service squid start

uuid=$(cat /proc/sys/kernel/random/uuid)
cat <<EOF > /etc/trojan/config.json
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 2087,
    "remote_addr": "127.0.0.1",
    "remote_port": 2603,
    "password": [
        "$uuid"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/etc/v2ray/v2ray.crt",
        "key": "/etc/v2ray/v2ray.key",
        "key_password": "",
        "cipher": "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384",
        "cipher_tls13": "TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
        "prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "prefer_ipv4": false,
        "no_delay": true,
        "keep_alive": true,
        "reuse_port": false,
        "fast_open": false,
        "fast_open_qlen": 20
    },
    "mysql": {
        "enabled": false,
        "server_addr": "127.0.0.1",
        "server_port": 3306,
        "database": "trojan",
        "username": "trojan",
        "password": "",
        "key": "",
        "cert": "",
        "ca": ""
    }
}
EOF
cat <<EOF> /etc/systemd/system/trojan.service
[Unit]
Description=Trojan
Documentation=https://trojan-gfw.github.io/trojan/

[Service]
Type=simple
ExecStart=/usr/local/bin/trojan -c /etc/trojan/config.json -l /var/log/trojan.log
Type=simple
KillMode=process
Restart=no
RestartSec=42s

[Install]
WantedBy=multi-user.target

EOF

cat <<EOF > /etc/trojan/uuid.txt
$uuid
EOF
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2087 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2087 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl restart trojan
systemctl enable trojan

cd /usr/bin
wget -O add-tr "https://raw.githubusercontent.com/vpnlegasi/scv1/main/add-tr.sh"
wget -O del-tr "https://raw.githubusercontent.com/vpnlegasi/scv1/main/del-tr.sh"
wget -O cek-tr "https://raw.githubusercontent.com/vpnlegasi/scv1/main/cek-tr.sh"
wget -O renew-tr "https://raw.githubusercontent.com/vpnlegasi/scv1/main/renew-tr.sh"
chmod +x add-tr
chmod +x cek-tr
chmod +x del-tr
chmod +x renew-tr
cd
rm -f ins-vt.sh
cp /root/domain /etc/v2ray
