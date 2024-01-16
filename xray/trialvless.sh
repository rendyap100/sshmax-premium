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
tls="$(cat ~/log-install.txt | grep -w "Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless WS none TLS" | cut -d: -f2|sed 's/ //g')"
user=trial-vl`</dev/urandom tr -dc 0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
Quota=5
iplimit=2
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
systemctl restart xray
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
DATADB=$(cat /etc/vless/.vless.db | grep "^#&" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vless/.vless.db
fi
echo "#& ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/vless/.vless.db
clear

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
#  Quota="0"
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
#echo "#& ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/vless/.vless.db
#echo "#& ${user} ${exp} ${uuid} ${Quota}" >>/etc/vless/.vless.db
#clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}" 
echo -e "${BIWhite}            ⇱ VLESS ACCOUNT ⇲            ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "User limit     : ${Quota} GB"
echo -e "Ip   limit     : ${iplimit} Ip"
echo -e "Wildcard       : (bug.com).${domain}"
echo -e "Port TLS       : 443"
echo -e "Port none TLS  : 80"
echo -e "Port gRPC      : 443"
echo -e "ID             : ${uuid}"
echo -e "Encryption     : none"
echo -e "Network        : ws"
echo -e "Path           : /vless"
echo -e "Path           : vless-grpc"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Link TLS       : ${vlesslink1}"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Link none TLS  : ${vlesslink2}"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Link gRPC      : ${vlesslink3}"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Expired On     : $exp"
echo -e "Regulation     : No ddos No torrent No porn"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-vless

