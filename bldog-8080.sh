#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear;
if [ ! -e "/dev/net/tun" ]; then
mkdir /dev/net; mknod /dev/net/tun c 10 200
fi
cd /
# Logo 	******************************************************************
CopyrightLogo='
==========================================================================
                                                          
                            变脸狗V1.8实时计费-脚本安装                                  
                          Powered by www.bldog.cn 2015-2016                     
                           本系统只支持CentOS 6.x 64系统                  
                                                                            
                                                    by 变脸狗             
==========================================================================';
echo "$CopyrightLogo";
echo 
if [[ ! -e /dev/net/tun ]] ;then
	echo -e "\033[0;31;1mtun网卡未开启\033[0m"
	exit
fi
myip=`wget http://ipecho.net/plain -O - -q ; echo`
echo "正在初始化部署环境..."
rm -rf /root/*
rm -rf /home/*
rm -rf /etc/openvpn
mkdir /etc/openvpn
echo "更新软件源（该过程大概5-20分钟,请勿回车）..."
yum -y update >/dev/null 2>&1
echo "部署成功匹配系统中（该过程也很慢,大概10分钟，请勿回车）..."
wget https://gitee.com/qt1280/Bldog/raw/master/epel-release-6-8.noarch.rpm  >/dev/null 2>&1
rpm -Uvh rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm >/dev/null 2>&1
yum makecache >/dev/null 2>&1
yum -y install httpd php php-mysql httpd-manual mod_ssl mod_perl mod_auth_mysql php-mcrypt php-gd php-xml php-mbstring php-ldap php-pear php-xmlrpc mysql-connector-odbc mysql-devel libdbi-dbd-mysql >/dev/null 2>&1
yum install -y tar zip unzip vim gcc-c++ gcc g++ make curl wget unzip iptables openssl openvpn lzop git clang >/dev/null 2>&1
chkconfig httpd on >/dev/null 2>&1
service httpd start >/dev/null 2>&1


_vpn_port="440"
_pxy_port="8080"
echo "写入负载配置文件"
for _port in $_vpn_port ;do
_dc="$_dc$_port,"
echo "local 0.0.0.0
port $_port
proto tcp
dev tun
ca /etc/openvpn/easy-rsa/2.0/keys/ca.crt
cert /etc/openvpn/easy-rsa/2.0/keys/server.crt
key /etc/openvpn/easy-rsa/2.0/keys/server.key
dh /etc/openvpn/easy-rsa/2.0/keys/dh1024.pe
ifconfig-pool-persist ipp.txt
server 192.1.0.0 255.255.255.0
push \"redirect-gateway\"
push \"dhcp-option DNS 114.114.114.114\"
push \"dhcp-option DNS 114.114.115.115\"
client-to-client
script-security 3 
management localhost 7505
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/logout.sh
username-as-common-name
verify-client-cert
#client-cert-not-required
#duplicate-cn
keepalive 20 60
comp-lzo
max-clients 50
persist-key
persist-tun
status /etc/openvpn/web/res/openvpn-status.log
log-append openvpn.log
verb 3
mute 20
management localhost 7505
">/etc/openvpn/server.conf
done





echo "请选择接入类型："
echo -e "1：新建云免主机"
echo -e "2：接入已有云免主机"

cd /etc/openvpn
read choose
if [[ ${choose%%\ *} == 1 ]]
    then
echo ip=$myip >2
cat 1 2 3 >logout.sh
echo "#!/bin/sh" >1
wget https://gitee.com/qt1280/Bldog/raw/master/3 >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/5 >/dev/null 2>&1
cat 1 2 5 >login.sh

echo "安装Mysql数据库中.....（请勿回车，大概5-20分钟）"
#yum -y remove mysql-* >/dev/null 2>&1
#rpm -e mysql-libs --nodeps
#yum -y remove mysql mysql-devel
#rpm -Uvh https://oa9l8uvo8.qnssl.com/xz/MySQL-shared-5.5.50-1.x86_64.rpm
#rpm -Uvh https://oa9l8uvo8.qnssl.com/xz/MySQL-client-5.5.50-1.x86_64.rpm
#rpm -Uvh https://oa9l8uvo8.qnssl.com/xz/MySQL-server-5.5.50-1.x86_64.rpm
#rpm -Uvh https://oa9l8uvo8.qnssl.com/xz/MySQL-devel-5.5.50-1.x86_64.rpm

rpm -e mysql-libs --nodeps
rpm -Uvh https://gitee.com/qt1280/Bldog/raw/master/epel-release-6-8.noarch.rpm >/dev/null 2>&1
rpm -Uvh https://github.com/joe1280/freeflow/raw/master/remi-release-6.rpm >/dev/null 2>&1
yum --enablerepo=remi,remi-test list mysql mysql-server >/dev/null 2>&1
yum --enablerepo=remi,remi-test install -y mysql mysql-server >/dev/null 2>&1
/etc/init.d/mysqld start >/dev/null 2>&1
chkconfig --levels 345 mysqld on >/dev/null 2>&1


#service mysql restart 
echo "新建数据库中长时间等待按回车....."
mysqladmin -u root password 'root' >/dev/null 2>&1
mysql -u root -proot << EOF 2>/dev/null
create database ov
EOF
service mysql restart >/dev/null 2>&1
echo
cd /etc/openvpn
mkdir web
cd web
echo "部署网站服务器..."
wget https://raw.githubusercontent.com/joe1280/freeflow/master/web.zip >/dev/null 2>&1
unzip -o web.zip >/dev/null 2>&1
chmod 777 ./*.php >/dev/null 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.txt >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/httpd.conf >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/php.ini >/dev/null 2>&1
cp -rf /etc/openvpn/web/httpd.conf /etc/httpd/conf/httpd.conf
cp -rf /etc/openvpn/web/php.ini /etc/php.ini
service httpd restart >/dev/null 2>&1
yum -y install telnet >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/jiankong/peizhi.cfg -O /etc/openvpn/peizhi.cfg >/dev/null 2>&1
echo "正在准备生成购买配置，请复制提示所需地址在shell中粘贴！新手不建议手工录入"
sleep 3
echo -n "请输入购买卡密链接：(回车略过即可) "
read buybuy
echo -n "请输入联系方式：(回车略过即可) "
read chat
echo -n "请输入APP下载地址（回车略过即可）： "
read down
echo "
<a href=\"$buybuy\" class=\"btn btn btn-danger btn-large\" target=\"_blank\">购买卡密</a>
<a href=\"$chat\" class=\"btn btn btn-warning btn-large\" target=\"_blank\">联系我们</a>
<a href=\"http://$down\" class=\"btn btn btn-danger btn-large\" target=\"_blank\">客户端下载</a>
">/etc/openvpn/web/user/plus.php
chu=`wget http://$myip//install.php?do=2 -O - -q ; echo`
shi=`wget http://$myip//install.php?do=3 -O - -q ; echo`
rm -f web.zip >/dev/null 2>&1
rm -f install.php >/dev/null 2>&1
echo -e "你的流控地址为：\033[0;32;1m http://$myip\033[0m，这是用户前台"
echo -e "你的流控后台为 ：\033[0;32;1m http://$myip/daili\033[0m 这是代理中心"
echo -e "你的流控后台为：\033[0;32;1m http://$myip/admin\033[0m 这是管理后台"
sleep 3 ;
else
echo "请输入老服务器IP："
read old
echo ip=$old >2
echo "#!/bin/sh" >1
wget https://gitee.com/qt1280/Bldog/raw/master/3 >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/5 >/dev/null 2>&1
cat 1 2 3 >logout.sh
cat 1 2 5 >login.sh
cd /etc/openvpn
mkdir web
cd web
echo "部署服务器..."
wget https://gitee.com/qt1280/Bldog/raw/master/httpd.conf >/dev/null 2>&1
cp -rf /etc/openvpn/web/httpd.conf /etc/httpd/conf/httpd.conf
service httpd restart >/dev/null 2>&1
fi
cd /etc/openvpn
#gzexe login.sh >/dev/null 2>&1
#gzexe logout.sh >/dev/null 2>&1
rm -f 1 >/dev/null 2>&1
rm -f 2 >/dev/null 2>&1
rm -f 3 >/dev/null 2>&1
rm -f 5 >/dev/null 2>&1
rm -f login.sh~ >/dev/null 2>&1
rm -f logout.sh~ >/dev/null 2>&1
chmod 777 /etc/openvpn/login.sh
chmod 777 /etc/openvpn/logout.sh
yum -y install telnet >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/jiankong/peizhi.cfg -O /etc/openvpn/peizhi.cfg >/dev/null 2>&1
mkdir /etc/openvpn/web/res >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/jiankong/jiankong -O /etc/openvpn/web/res/jiankong >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/jiankong/sha -O /etc/openvpn/web/res/sha >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/jiankong/openvpn-status.log -O /etc/openvpn/web/res/openvpn-status.log >/dev/null 2>&1
wget https://gitee.com/qt1280/Bldog/raw/master/jiankong/openvpn-status.txt -O /etc/openvpn/web/res/openvpn-status.txt >/dev/null 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.log 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.txt 2>&1
chmod 777 /etc/openvpn/web/res/jiankong 2>&1
chmod 777 /etc/openvpn/web/res/sha 2>&1
nohup /etc/openvpn/web/res/jiankong >>/etc/openvpn/web/res/jiankong.log 2>&1 &




echo “安装openvpn”
cd /etc/openvpn/
#wget https://gitee.com/qt1280/Bldog/raw/master/easy-rsa.tar.gz >/dev/null 2>&1
wget https://github.com/joe1280/freeflow/raw/master/easy-rsa.zip >/dev/null 2>&1
unzip easy-rsa.zip
#tar -zxvf easy-rsa.tar.gz >/dev/null 2>&1


echo "开始编译代理程序……"
cd /root/
wget --no-check-certificate https://github.com/joe1280/freeflow/raw/master/mproxy.c >/dev/null 2>&1
sleep 1
rm -f /bin/xx >/dev/null 2>&1
gcc -DPORTS=$_dc -o /bin/xx mproxy.c >/dev/null 2>&1
chmod 777 /bin/xx >/dev/null 2>&1
rm -f /root/mproxy.c >/dev/null 2>&1



echo "正在写入线路配置..."
cd /etc/openvpn
echo "
client
dev tun
proto tcp
remote wap.10086.cn 443
http-proxy $myip 8080
resolv-retry infinite
nobind
persist-key
persist-tun
auth-user-pass
#ns-cert-type server
remote-cert-tls server
auth-nocache
redirect-gateway
keepalive 20 180
comp-lzo
verb 3
mute 20
route-method exe
route-delay 2
<ca>
`cat ./easy-rsa/2.0/keys/ca.crt`
</ca>
<cert>
`cat ./easy-rsa/2.0/keys/client.crt`
</cert>
<key>
`cat ./easy-rsa/2.0/keys/client.key`
</key>
" >YiDong.ovpn
echo "
client
dev tun
proto tcp
remote dl.music.189.cn 443
http-proxy $myip 8080
resolv-retry infinite
nobind
persist-key
persist-tun
auth-user-pass
ns-cert-type server
redirect-gateway
keepalive 20 180
comp-lzo
verb 3
mute 20
route-method exe
route-delay 2
<ca>
`cat ./easy-rsa/2.0/keys/ca.crt`
</ca>
<cert>
`cat ./easy-rsa/2.0/keys/client.crt`
</cert>
<key>
`cat ./easy-rsa/2.0/keys/client.key`
</key>
" >DianXin.ovpn
echo "
client
dev tun
proto tcp
remote wap.17wo.cn 443
http-proxy $myip 8080
resolv-retry infinite
nobind
persist-key
persist-tun
auth-user-pass
ns-cert-type server
redirect-gateway
keepalive 20 180
comp-lzo
verb 3
mute 20
route-method exe
route-delay 2
<ca>
`cat ./easy-rsa/2.0/keys/ca.crt`
</ca>
<cert>
`cat ./easy-rsa/2.0/keys/client.crt`
</cert>
<key>
`cat ./easy-rsa/2.0/keys/client.key`
</key>
" >LianTong.ovpn


echo “正在写入启动命令”
echo "#!/bin/sh
setenforce 0 >/dev/null 2>&1
echo 1 >/proc/sys/net/ipv4/ip_forward 2>/dev/null
iptables -F
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -j SNAT --to-source `wget -O - http://ipecho.net/plain 2>/dev/null`
service openvpn restart
killall xx >/dev/null 2>/dev/null
for _pxy in $_pxy_port ;do
xx -l \$_pxy >/dev/null 2>&1
done
">/bin/vpn
chmod 0777 /bin/vpn
echo "/bin/vpn" > /etc/rc.local 

echo “正在写入防火墙配置如果centos无法请执行vpn1”
echo "#!/bin/sh
echo 'net.ipv4.ip_forward=1' >/etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -j SNAT --to-source $myip
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -p TCP --dport 8080 -j ACCEPT
iptables -A INPUT -p TCP --dport 22 -j ACCEPT
iptables -A INPUT -p TCP --dport 440 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
service iptables save
service iptables restart
chkconfig iptables on
setenforce 0
">/bin/vpn1
chmod 0777 /bin/vpn1
echo "开启全部服务中（快速开启命令vpn）……"
tar zcf bldog.tar.gz ./{YiDong.ovpn,LianTong.ovpn,DianXin.ovpn}
cp -rf /etc/openvpn/bldog.tar.gz /etc/openvpn/web/bldog.tar.gz
rm -f ./bldog.tar.gz
rm -f ./*.ovpn
vpn1 >/dev/null 2>/dev/null
vpn >/dev/null 2>/dev/null
echo "服务安装完毕"
echo -e "你的配置文件为：\033[0;32;1m http://$myip/bldog.tar.gz\033[0m，请复制到浏览器下载"
vpn

rm -rf /install
