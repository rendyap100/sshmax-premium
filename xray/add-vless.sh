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
source /var/lib/SIJA/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless WS none TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}        ⇱ ADD VLESS ACCOUNT ⇲        ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"

read -rp "User: " -e user
CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}        ⇱ ADD VLESS ACCOUNT ⇲        ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
echo "A client with the specified name was already created, please choose another name."
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-vless
fi
done

#uuid=$(cat /proc/sys/kernel/random/uuid)
read -p " CREAT PW (OTOMATIC RANDOM PW) :" uuid
    [[ -z "$uuid" ]] && uuid=`cat /proc/sys/kernel/random/uuid`
sec=3
echo ""
spinner=(⣻ ⢿ ⡿ ⣟ ⣯ ⣷)
while [ $sec -gt 0 ]; do
  echo -ne "\e[33m ${spinner[sec]} Setting up a Premium Account $sec seconds...\r"
  sleep 1
  sec=$(($sec - 1))
done
clear
echo ""
echo -e "\e[1;32m   input dependecies account $user\e[0m\n"
echo -e "\033[0;33m .::.  Script by CLOUDVPN  .::.\e[0m\n"
echo ""
echo "   Setup Limit Quota/ip for Account"
echo "       0 For Unlimited/No Limit"
echo ""
echo "   Username : $user"
until [[ $masaaktif =~ ^[0-9]+$ ]]; do
read -p "   Expired (days): " masaaktif
done
until [[ $Quota =~ ^[0-9]+$ ]]; do
  read -p "   Limit User (GB): " Quota
done
until [[ $iplimit =~ ^[0-9]+$ ]]; do
  mkdir -p /etc/kyt/limit/vless/ip
  read -p "   Limit User (IP): " iplimit
done    
#read -p "Expired (days): " masaaktif
#read -p "Limit User (GB): " Quota
#read -p "Limit User (IP): " iplimit
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"
systemctl restart xray
#if [ ! -e /etc/vless ]; then
  #mkdir -p /etc/vless
#fi
#if [ -z ${iplimit} ]; then
 # iplimit="0"
#fi
#if [ -z ${Quota} ]; then
#  Quota="0"
#fi
#c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
#d=$((${c} * 1024 * 1024 * 1024))
#if [[ ${c} != "0" ]]; then
#  echo "${d}" >/etc/vless/${user}
#  echo "${iplimit}" >/etc/kyt/limit/vless/ip/$user
#fi
#DATADB=$(cat /etc/vless/.vless.db | grep "^#&" | grep -w "${user}" | awk '{print $2}')
#if [[ "${DATADB}" != '' ]]; then
#  sed -i "/\b${user}\b/d" /etc/vless/.vless.db
#fi
#echo "#& ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/vless/.vless.db
#if [ ! -e /etc/vless ]; then
#mkdir -p /etc/vless
#fi

#if [[ $quota -gt 0 ]]; then
#echo -e "$[$quota * 1024 * 1024 * 1024]" > /etc/kyt/limit/vless/quota/$user
#else
#echo > /dev/null
#fi

#if [[ $iplimit -gt 0 ]]; then
#mkdir -p /etc/kyt/limit/vless/ip
#echo -e "$iplimit" > /etc/kyt/limit/vless/ip/$user
#else
#echo > /dev/null
#fi

#if [ -z ${Quota} ]; then
#Quota="0"
#fi

#c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
#d=$((${c} * 1024 * 1024 * 1024))
#if [[ ${c} != "0" ]]; then
  #echo "${d}" >/etc/vless/${user}
#fi
#DATADB=$(cat /etc/vless/.vless.db | grep "^#&" | grep -w "${user}" | awk '{print $2}')
#if [[ "${DATADB}" != '' ]]; then
#sed -i "/\b${user}\b/d" /etc/vless/.vless.db
#fi

if [ ! -e /etc/vless ]; then
  mkdir -p /etc/vless
fi
if [ -z ${iplimit} ]; then
  iplimit="0"
fi
if [ -z ${Quota} ]; then
  Quota="0"
fi
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vless/${user}
  echo "${iplimit}" >/etc/kyt/limit/vless/ip/$user
fi
DATADB=$(cat /etc/vless/.vless.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vless/.vless.db
fi
echo "#& ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/vless/.vless.db
#echo "#& ${user} ${exp} ${uuid} ${Quota}" >>/etc/vless/.vless.db
clear
echo -e ""
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}" | tee -a /etc/log-create-user.log 
echo -e "${BIWhite}            ⇱ VLESS ACCOUNT ⇲            ${NC}" | tee -a /etc/log-create-user.log
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}" | tee -a /etc/log-create-user.log
echo -e "Remarks        : ${user}" | tee -a /etc/log-create-user.log
echo -e "Domain         : ${domain}" | tee -a /etc/log-create-user.log
echo -e "User Quota     : ${Quota} GB" | tee -a /etc/log-create-user.log
echo -e "User Ip        : ${iplimit} IP" | tee -a /etc/log-create-user.log
echo -e "Wildcard       : (bug.com).${domain}" | tee -a /etc/log-create-user.log
echo -e "Port TLS       : 443" | tee -a /etc/log-create-user.log
echo -e "Port none TLS  : 80" | tee -a /etc/log-create-user.log
echo -e "Port  GRPC     : 443" | tee -a /etc/log-create-user.log
echo -e "id             : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "Encryption     : none" | tee -a /etc/log-create-user.log
echo -e "Network        : ws" | tee -a /etc/log-create-user.log
echo -e "Path           : /vless" | tee -a /etc/log-create-user.log
echo -e "Path           : vless-grpc" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link TLS       : ${vlesslink1}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link none TLS  : ${vlesslink2}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link gRPC      : ${vlesslink3}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Expired On     : $exp" | tee -a /etc/log-create-user.log
echo -e "Regulation     : No ddos No torrent No porn" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"

menu-vless
