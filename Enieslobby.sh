#!/bin/bash
echo '
nameserver 192.168.122.1 
# nameserver 192.182.2.4
' > /etc/resolv.conf

apt-get update

apt-get install bind9 -y
echo '
zone "franky.B11.com" {
    type master;
    allow-transfer { 192.182.2.3; };
    file "/etc/bind/kaizoku/franky.B11.com";
};

zone "2.182.192.in-addr.arpa" {
    type master;
    file "/etc/bind/kaizoku/2.182.192.in-addr.arpa";
};
' > /etc/bind/named.conf.local

mkdir /etc/bind/kaizoku
cp /etc/bind/db.local /etc/bind/kaizoku/franky.B11.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     franky.B11.com. root.franky.B11.com. (
                        2021102501      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                       IN      NS      franky.B11.com.
@                       IN      A       192.182.2.4        ; IP Skypie
www                     IN      CNAME   franky.B11.com.
super                   IN      A       192.182.2.4        ; IP Skypie
www.super               IN      CNAME   franky.B11.com.
ns1                     IN      A       192.182.2.4        ; IP Skypie
mencha                  IN      NS      ns1
' > /etc/bind/kaizoku/franky.B11.com

cp /etc/bind/db.local /etc/bind/kaizoku/2.182.192.in-addr.arpa
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     franky.B11.com. root.franky.B11.com. (
                     2021102501         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.182.192.in-addr.arpa.    IN      NS      franky.B11.com.
2                       IN      PTR     franky.B11.com.
' > /etc/bind/kaizoku/2.182.192.in-addr.arpa

echo '
options {
        directory "/var/cache/bind";

        // forwarders {
        //  192.168.122.1;
        // };

        // dnssec-validation auto;

        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

service bind9 restart
