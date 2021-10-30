#!/bin/bash

echo '
nameserver 192.168.122.1 
# nameserver 192.182.2.2
' > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

echo '
zone "franky.B11.com" {
    type slave;
    masters { 192.182.2.2; };
    file "/var/lib/bind/franky.B11.com";
};

zone "mencha.franky.B11.com" {
    type master;
    file "/etc/bind/sunnygo/mencha.franky.B11.com";
};
' > /etc/bind/named.conf.local

echo '
options {
        directory "/var/cache/bind";

        // forwarders {
        //      0.0.0.0;
        // };

        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

mkdir /etc/bind/sunnygo
cp /etc/bind/db.local /etc/bind/sunnygo/mencha.franky.B11.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA  mencha.franky.B11.com. root.mencha.franky.B11.com. (
                     2021102501             ; Serial
                         604800             ; Refresh
                          86400             ; Retry
                        2419200             ; Expire
                         604800 )           ; Negative Cache TTL
;
@               IN      NS      mencha.franky.B11.com.
@               IN      A       192.182.2.4        ; IP Skypie
mencha          IN      A       192.182.2.4        ; IP Skypie
www             IN      CNAME   mencha.franky.B11.com.
general         IN      A       192.182.2.4        ; IP Skypie
www.general     IN      CNAME   mencha.franky.B11.com.
' > /etc/bind/sunnygo/mencha.franky.B11.com


echo '
# nameserver 192.168.122.1 
nameserver 192.182.2.2
' > /etc/resolv.conf

service bind9 restart
