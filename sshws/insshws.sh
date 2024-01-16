#!/bin/bash
#installer Websocker tunneling 

cd
apt install python -y

#Install Script Websocket-SSH Python
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/dropbear-ws2.py
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/ws-stunnel2

#izin permision
chmod +x /usr/local/bin/ws-dropbear
chmod +x /usr/local/bin/ws-stunnel


#System Dropbear Websocket-SSH Python
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/service-wsdropbear2 && chmod +x /etc/systemd/system/ws-dropbear.service

#System SSL/TLS Websocket-SSH Python
wget -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/sshws/ws-stunnel2.service && chmod +x /etc/systemd/system/ws-stunnel.service

#restart service
#
systemctl daemon-reload

#Enable & Start & Restart ws-dropbear service
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

#Enable & Start & Restart ws-openssh service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service

clear
