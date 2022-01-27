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
clear
# ===================================
# Xray Quick Setup
# xtls by VPN Legasi
# ===================================

export port='443' #Vless RPRX Direct
export Cert_path='/etc/v2ray/v2ray.crt' # >> Cert Path
export Cert_Key_Path='/etc/v2ray/v2ray.key' #Cert Key Path

# Creating UUID
export uuid=$(cat /proc/sys/kernel/random/uuid)

# // Installing Requirement
apt update -y
apt upgrade  -y
apt install zip unzip gzip curl wget nano vim -y

# // Downloading Core
wget -O /usr/local/xray-mini "https://raw.githubusercontent.com/vpnlegasi/scv1/main/xray-mini"
chmod +x /usr/local/xray-mini

# // Make Config Folder
mkdir -p /etc/xray-mini/

# // Installing Service
cat > /etc/systemd/system/xray-mini.service << END
[Unit]
Description=XRay-Mini
Documentation=https://vpnlegasi.xyz
After=syslog.target network-online.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray-mini -c /etc/xray-mini/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
END

cat > /etc/systemd/system/xray-mini.service << END
[Unit]
Description=XRay-Mini
Documentation=https://vpnlegasi.xyz
After=syslog.target network-online.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray-mini -c /etc/xray-mini/trojan.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
END
# // XRay XTLS RPRX Direct
cat > /etc/xray-mini/config.json << END
{
  "log": {
    "access": "/var/log/xray/access3.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": ${port},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-direct"
#XRay
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 60000,
            "alpn": "",
            "xver": 1
          },
          {
            "dest": 60001,
            "alpn": "h2",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "${Cert_path}",
              "keyFile": "${Cert_Key_Path}"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END
cat > /etc/xray-mini/trojan.json << END
{
  "log": {
    "access": "/var/log/xray/access4.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
    "inbounds": [
        {
            "port": 443,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password":"$user",
                        "email": "ovpnlegasi@gmail.com"
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "tls",
                "tlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "${Cert_path}",
                            "keyFile": "${Cert_Key_Path}"
                        }
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
END

iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables-save >/etc/iptables.rules.v4
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload


systemctl disable xray-mini
systemctl stop xray-mini
systemctl enable xray-mini
systemctl start xray-mini

# // Downloading Menu
cd /usr/bin

wget -O add-xtls "https://raw.githubusercontent.com/vpnlegasi/scv1/main/add-xtls.sh"
wget -O del-xtls "https://raw.githubusercontent.com/vpnlegasi/scv1/main/del-xtls.sh"
wget -O renew-xtls "https://raw.githubusercontent.com/vpnlegasi/scv1/main/renew-xtls.sh"
wget -O cek-xtls "https://raw.githubusercontent.com/vpnlegasi/scv1/main/cek-xtls.sh"
wget -O trial-xtls "https://raw.githubusercontent.com/vpnlegasi/scv1/main/trial-xtls.sh"
wget -O xtls-exp "https://raw.githubusercontent.com/vpnlegasi/scv1/main/xtls-exp.sh"
wget -O xray-tr "https://raw.githubusercontent.com/vpnlegasi/scv1/main/xray-tr.sh"

chmod +x add-xtls
chmod +x del-xtls
chmod +x renew-xtls
chmod +x cek-xtls
chmod +x trial-xtls
chmod +x xtls-exp
chmod +x xray-tr

# // Remove Not Used Files
rm -f install-xray.sh