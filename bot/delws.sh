#!/bin/bash

MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

clear

if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")

clear
echo -e "┌─────────────────────────────────────────────────┐"
echo -e "           • DELETE XRAY USER •              "
echo -e "└─────────────────────────────────────────────────┘"
echo -e "┌─────────────────────────────────────────────────┐"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e ""
echo -e "  • [NOTE] Press any key to back on menu"
echo -e "└─────────────────────────────────────────────────┘"   
echo -e "───────────────────────────────────────────────────"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vmess
else
exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "┌─────────────────────────────────────────────────┐"
echo -e "│              • DELETE XRAY USER •               │"
echo -e "└─────────────────────────────────────────────────┘"
echo -e "┌─────────────────────────────────────────────────┐"
echo -e "    • Accound Delete Successfully"
echo -e " "
echo -e "    • Client Name : $user"
echo -e "    • Expired On  : $exp"
echo -e "└─────────────────────────────────────────────────┘" 
echo ""
#read -n 1 -s -r -p "   Press any key to back on menu"
#menuv
fi

