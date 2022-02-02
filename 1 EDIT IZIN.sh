#!/bin/bash

#EDIT SETUP IZIN

IZIN=$( curl https://raw.githubusercontent.com/vpnlegasi/ipv1.0/main/access | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo -e "${red}Please Contact Admin  # NAK DAFTAR IP ? CONTACT SAYA @vpnlegasi DI TELEGRAM#${NC}"
rm -f setup.sh
exit 0
fi

#EDIT IZIN

IZIN=$( curl https://raw.githubusercontent.com/vpnlegasi/ipv1.0/main/access | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo -e "${red}Please Contact Admin  # NAK DAFTAR IP ? CONTACT SAYA @vpnlegasi DI TELEGRAM#${NC}"
exit 0
fi