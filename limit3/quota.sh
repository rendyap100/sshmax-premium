REPO="https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/"
wget -q -O /etc/systemd/system/limitvmess.service "${REPO}limit3/limitvmess.service" && chmod +x limitvmess.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitvless.service "${REPO}limit3/limitvless.service" && chmod +x limitvless.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limittrojan.service "${REPO}limit3/limittrojan.service" && chmod +x limittrojan.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitshadowsocks.service "${REPO}limit3/limitshadowsocks.service" && chmod +x limitshadowsocks.service >/dev/null 2>&1
wget -q -O /etc/xray/limit.vmess "${REPO}limit3/vmess" >/dev/null 2>&1
wget -q -O /etc/xray/limit.vless "${REPO}limit3/vless" >/dev/null 2>&1
wget -q -O /etc/xray/limit.trojan "${REPO}limit3/trojan" >/dev/null 2>&1
wget -q -O /etc/xray/limit.shadowsocks "${REPO}limit3/shadowsocks" >/dev/null 2>&1
#wget https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/limi3/ip-shadowsocks
#wget https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/limi3/ip-trojan
#wget https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/limi3/ip-vless
#wget https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/limi3/ip-vmess
#wget https://raw.githubusercontent.com/rendyap100/sshmax-premium/main/limi3/limit
chmod +x /etc/xray/limit.vmess
chmod +x /etc/xray/limit.vless
chmod +x /etc/xray/limit.trojan
chmod +x /etc/xray/limit.shadowsocks
systemctl daemon-reload
systemctl enable --now limitvmess
systemctl enable --now limitvless
systemctl enable --now limittrojan
systemctl enable --now limitshadowsocks
