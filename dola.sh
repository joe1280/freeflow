#!/bin/bash
yum install - y wget lrzsz
wget https://github.com/joe1280/freeflow/raw/master/epel-release-6-8.noarch.rpm  >/dev/null 2>&1
rpm -Uvh epel-release-6-8.noarch.rpm >/dev/null 2>&1
wget https://od.lk/s/NTNfNDE1Mjc2OF8/install.tgz 
tar -xzvf install.tgz
cd install
chmod 755 yum-openvpn+mysql+redius.sh
./yum-openvpn+mysql+redius.sh
