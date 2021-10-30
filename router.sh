#!/bin/bash

apt-get update
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.182.0.0/16