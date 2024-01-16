#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
echo -e " [INFO] Downloading Update File"
sleep 2
# hapus menu
rm -rf /usr/local/bin/ws-openssh
rm -rf /usr/local/bin/ws-dropbear
rm -rf /usr/local/bin/ws-stunnel
rm -rf /usr/local/bin/edu-proxy


rm -rf /etc/systemd/system/ws-openssh.service
rm -rf /etc/systemd/system/ws-dropbear.service
rm -rf /etc/systemd/system/ws-stunnel.service
rm -rf /etc/systemd/system/edu-proxy.service

curl "https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/insshws.sh" | bash

wget -O /usr/local/bin/ws-openssh https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/openssh-socket2.py
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/dropbear-ws2.py
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/ws-stunnel2
wget -O /usr/local/bin/edu-proxy https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/https.py

systemctl daemon-reload
Enable & Start & Restart ws-openssh service
systemctl enable ws-openssh.service
systemctl start ws-openssh.service
systemctl restart ws-openssh.service

#Enable & Start & Restart ws-dropbear service
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

#Enable & Start & Restart ws-openssh service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service

#Enable & Start & Restart directly dropbear
systemctl daemon-reload
systemctl enable edu-proxy.service
systemctl start edu-proxy.service
systemctl restart edu-proxy.service

echo -e " [INFO] Update Successfully"
sleep 2
menu
