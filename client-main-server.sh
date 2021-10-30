#!/bin/bash

echo '
nameserver 192.168.122.1
# nameserver 192.182.2.2
# nameserver 192.182.2.3
# nameserver 192.182.2.4
' > /etc/resolv.conf

apt-get update

apt-get install dnsutils -y

apt-get install lynx -y

echo '
# nameserver 192.168.122.1
nameserver 192.182.2.2
nameserver 192.182.2.3
# nameserver 192.182.2.4
' > /etc/resolv.conf