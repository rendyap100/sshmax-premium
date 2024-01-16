#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m" 

BURIQ () {
    curl -sS https://raw.githubusercontent.com/rendyap100/izin/main/izin > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/rendyap100/izin/main/izin | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/rendyap100/izin/main/izin | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/vless/.vless.db")
        if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
                clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}               ⇱ VLESS MENU ⇲            ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
                echo ""
                echo "You have no existing clients!"
                echo ""
                echo -e "\033[35m══════════════════════════════════════════\e[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        menu
        fi

        clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}               ⇱ VLESS MENU ⇲            ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
    echo ""
        grep -E "^#& " "/etc/vless/.vless.db" | cut -d ' ' -f 2 | column -t | sort | uniq
    echo ""
    red "tap enter to go back"
    echo -e "\033[35m══════════════════════════════════════════\e[0m"
        read -rp "Input Username : " user
    if [ -z $user ]; then
    menu
    else
    read -p "Limit (Quota): " Quota
    echo -e "$[$Quota * 1024 * 1024 * 1024]" > /etc/vless/${user}
    clear
    echo -e "\033[0;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo " vless Account Was Successfully Edited"
    echo -e "\033[0;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo " Client Name  : $user"
    echo " Quota Ready  : $Quota GB"
    echo ""
    echo -e "\033[0;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu-vless
    fi
