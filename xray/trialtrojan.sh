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
domain=$(cat /etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "Trojan WS TLS" | cut -d: -f2|sed 's/ //g')"
ntls="$(cat ~/log-install.txt | grep -w "Trojan WS none TLS" | cut -d: -f2|sed 's/ //g')"
user=trial-tr`</dev/urandom tr -dc 0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
Quota=5
iplimit=2
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

systemctl restart xray
trojanlink1="trojan://${uuid}@isi_bug_disini:${tls}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"
trojanlink="trojan://${uuid}@isi_bug_disini:${tls}?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink2="trojan://${uuid}@isi_bug_disini:${ntls}?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws#${user}"
if [ ! -e /etc/trojan ]; then
  mkdir -p /etc/trojan
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi
if [ -z ${iplimit} ]; then
  iplimit="0"
fi
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
 echo "${d}" >/etc/trojan/${user}
 echo "${iplimit}" >/etc/kyt/limit/trojan/ip/$user
fi
DATADB=$(cat /etc/trojan/.trojan.db | grep "^#!" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/trojan/.trojan.db
fi
echo "#! ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/trojan/.trojan.db
clear

#if [ ! -e /etc/trojan ]; then
#mkdir -p /etc/trojan
#fi

#if [[ $quota -gt 0 ]]; then
#echo -e "$[$quota * 1024 * 1024 * 1024]" > /etc/kyt/limit/trojan/quota/$user
#else
#echo > /dev/null
#fi

#if [[ $iplimit -gt 0 ]]; then
#mkdir -p /etc/kyt/limit/trojan/ip
#echo -e "$iplimit" > /etc/kyt/limit/trojan/ip/$user
#else
#echo > /dev/null
#fi

#if [ -z ${Quota} ]; then
#Quota="0"
#fi

#c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
#d=$((${c} * 1024 * 1024 * 1024))

#if [[ ${c} != "0" ]]; then
#echo "${d}" >/etc/trojan/${user}
#fi
#DATADB=$(cat /etc/trojan/.trojan.db | grep "^#!" | grep -w "${user}" | awk '{print $2}')
#if [[ "${DATADB}" != '' ]]; then
#sed -i "/\b${user}\b/d" /etc/trojan/.trojan.db
#fi
#echo "#! ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/trojan/.trojan.db
#echo "#! ${user} ${exp} ${uuid} ${Quota}" >>/etc/trojan/.trojan.db
#clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m           TRIAL TROJAN          \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Host/IP        : ${domain}"
echo -e "User Quota     : ${Quota} GB"
echo -e "User Ip        : ${iplimit} IP"
echo -e "Wildcard       : (bug.com).${domain}"
echo -e "Port TLS       : 443"
echo -e "Port none TLS  : 80"
echo -e "Port gRPC      : 443"
echo -e "Key            : ${uuid}"
echo -e "Path           : /trojan-ws"
echo -e "ServiceName    : trojan-grpc"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link TLS       : ${trojanlink}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link none TLS  : ${trojanlink2}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link gRPC      : ${trojanlink1}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Expired On     : $exp"
echo -e "Regulation     : No ddos No torrent No porn"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

menu-vless
