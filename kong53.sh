#/bin/bash
yum -y install git gcc lrzsz
git clone https://github.com/examplecode/mproxy.git
cd mproxy
gcc -o mproxy mproxy.c
./mproxy -l 53 -d
iptables -A INPUT -p tcp --dport  53 -j ACCEPT
service iptables save
service iptables restart
