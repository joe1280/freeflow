#/bin/bash
setenforce 0
ulimit -n 1048576
echo "* soft nofile 1048576" >> /etc/security/limits.conf
echo "* hard nofile 1048576" >> /etc/security/limits.conf
echo "alias net-pf-10 off" >> /etc/modprobe.d/dist.conf
echo "alias ipv6 off" >> /etc/modprobe.d/dist.conf
killall sendmail
/etc/init.d/postfix stop
chkconfig --level 2345 postfix off
yum -y install squid
wget -O /etc/squid/squid.conf https://github.com/joe1280/freeflow/raw/master/centos-squid.conf
mkdir -p /var/cache/squid
chmod -R 777 /var/cache/squid
squid -z
service squid restart
chkconfig --level 2345 squid on
iptables -A INPUT -p tcp --dport  25 -j ACCEPT
echo -e "配置文件下载地址：https://github.com/joe1280/freeflow/raw/master/1.pac"  