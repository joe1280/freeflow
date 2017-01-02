#/bin/bash
yum -y install git gcc lrzsz
git clone https://github.com/examplecode/mproxy.git
cd mproxy
gcc -o mproxy mproxy.c
./mproxy -l 53 -d