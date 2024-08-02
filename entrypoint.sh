#!/bin/sh
set -e
iptables -t nat -A POSTROUTING -j MASQUERADE
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p
SERVER_IP=$(curl -s http://checkip.amazonaws.com)
if ! grep -q "no-route = ${SERVER_IP}/255.255.255.255" /etc/ocserv.conf; then
    echo "" >> /etc/ocserv.conf
    echo "no-route = ${SERVER_IP}/255.255.255.255" >> /etc/ocserv.conf
fi
exec "$@"
