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
            变脸狗V2.3全功能，开启137和138端口,论坛VIP专用脚本www.it53.cn
                           本系统只支持CentOS 6.x 64系统
                           后台登陆地址为：www.97cn.top
                                                    by 变脸狗             
==========================================================================';
echo "$CopyrightLogo";
echo 
echo -e "\033[0;32;1m授权账户注册地址：gl.97cn.net\033[0m"
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
wget http://oa9k346ck.bkt.clouddn.com/epel-release-6-8.noarch.rpm >/dev/null 2>&1
rpm -ivh epel-release-6-8.noarch.rpm >/dev/null 2>&1
yum clean all >/dev/null 2>&1
yum makecache >/dev/null 2>&1
#yum -y install httpd php php-mysql httpd-manual mod_ssl mod_perl mod_auth_mysql php-mcrypt php-gd php-xml php-mbstring php-ldap php-pear php-xmlrpc mysql-connector-odbc mysql-devel libdbi-dbd-mysql >/dev/null 2>&1 
yum install -y tar zip vim gcc-c++ gcc g++ make curl wget unzip iptables openssl openvpn lzop git clang >/dev/null 2>&1
chkconfig httpd on >/dev/null 2>&1
service httpd start >/dev/null 2>&1


_vpn_port="65442 440 65443 1194 3344"
_pxy_port="8080 80 138 137 53"
_vt=0
_xt=4
echo "写入负载配置文件"
for _port in $_vpn_port ;do
_vt=`expr $_vt + 1`
_xt=`expr $_xt + 1`
_dc="$_dc$_port,"
echo "local 0.0.0.0
port $_port
proto tcp
dev tun
ca /etc/openvpn/easy-rsa/2.0/keys/ca.crt
cert /etc/openvpn/easy-rsa/2.0/keys/server.crt
key /etc/openvpn/easy-rsa/2.0/keys/server.key
dh /etc/openvpn/easy-rsa/2.0/keys/dh1024.pem
ifconfig-pool-persist ipp.txt
server 192.$_vt.0.0 255.255.0.0
push \"redirect-gateway\"
push \"dhcp-option DNS $DNSIP\"
client-to-client
script-security 3 system
management localhost 750$_xt
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/logout.sh
username-as-common-name
client-cert-not-required
#duplicate-cn
keepalive 20 60
comp-lzo
persist-key
persist-tun
status status$_vt.txt
log-append openvpn.log
verb 3
mute 20
">/etc/openvpn/server$_vt.conf
done

cd /bin
rm -f kill >/dev/null 2>&1
wget http://oa9k346ck.bkt.clouddn.com/qc/kill >/dev/null 2>&1
chmod 777 /bin/kill




echo "请选择接入类型："
echo -e "1：新建云免主机"
echo -e "2：接入已有云免主机"

cd /etc/openvpn
read choose
if [[ ${choose%%\ *} == 1 ]]
    then
echo ip=$myip >2
echo "#!/bin/sh" >1
wget https://oa9l8uvo8.qnssl.com/cc/3 >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/cc/5 >/dev/null 2>&1
cat 1 2 3 >logout.sh
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
rpm -Uvh https://oa9l8uvo8.qnssl.com/epel/6/i386/epel-release-6-8.noarch.rpm >/dev/null 2>&1
rpm -Uvh https://oa9l8uvo8.qnssl.com/enterprise/remi-release-6.rpm >/dev/null 2>&1
#yum --enablerepo=remi,remi-test list mysql mysql-server >/dev/null 2>&1
#yum --enablerepo=remi,remi-test install -y mysql mysql-server >/dev/null 2>&1
#/etc/init.d/mysqld start >/dev/null 2>&1
#chkconfig --levels 345 mysqld on >/dev/null 2>&1


#service mysql restart 
#echo "新建数据库中长时间等待按回车....."
#mysqladmin -u root password 'root' >/dev/null 2>&1
#mysql -u root -proot << EOF 2>/dev/null
#create database ov
EOF
#service mysql restart >/dev/null 2>&1
#echo
cd /etc/openvpn
mkdir web
cd web
echo "部署网站服务器..."
wget https://oa9l8uvo8.qnssl.com/web2.2.zip >/dev/null 2>&1
unzip -o web2.2.zip >/dev/null 2>&1
chmod 777 ./*.php >/dev/null 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.txt >/dev/null 2>&1
mkdir -p /etc/httpd
mkdir -p /etc/httpd/conf
wget https://oa9l8uvo8.qnssl.com/httpd.conf >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/php.ini >/dev/null 2>&1
cp -rf /etc/openvpn/web/httpd.conf /etc/httpd/conf/httpd.conf
cp -rf /etc/openvpn/web/php.ini /etc/php.ini
service httpd restart >/dev/null 2>&1
yum -y install telnet >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/peizhi.cfg -O /etc/openvpn/peizhi.cfg >/dev/null 2>&1
echo "正在准备生成购买配置，请复制提示所需地址在shell中粘贴！新手不建议手工录入"
sleep 3
echo -n "137端口已开启(回车确认) "
read buybuy
echo -n "138端口已开启(回车确认) "
read chat
echo -n "开启成功（回车确认）： "
read down
echo "
<a href=\"$buybuy\" class=\"btn btn btn-danger btn-large\" target=\"_blank\">购买卡密</a>
<a href=\"$chat\" class=\"btn btn btn-warning btn-large\" target=\"_blank\">联系我们</a>
<a href=\"http://$down\" class=\"btn btn btn-danger btn-large\" target=\"_blank\">客户端下载</a>
">/etc/openvpn/web/user/plus.php
chu=`wget http://$myip//install.php?do=2 -O - -q ; echo`
shi=`wget http://$myip//install.php?do=3 -O - -q ; echo`
rm -f web2.2.zip >/dev/null 2>&1
rm -f install.php >/dev/null 2>&1
echo -e "你的流控地址为：\033[0;32;1m http://$myip\033[0m，这是用户前台"
echo -e "你的流控代理为 ：\033[0;32;1m http://$myip/daili\033[0m 这是代理中心"
echo -e "你的云端APP后台为：\033[0;32;1m http://$myip/admin\033[0m 这是APP管理后台，默认登陆账户密码都是admin"
sleep 3 ;
else
echo "请输入老服务器IP："
read old
echo ip=$old >2
echo "#!/bin/sh" >1
wget https://oa9l8uvo8.qnssl.com/cc/3 >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/cc/5 >/dev/null 2>&1
cat 1 2 3 >logout.sh
cat 1 2 5 >login.sh
cd /etc/openvpn
mkdir web
cd web
echo "部署服务器..."
wget https://oa9l8uvo8.qnssl.com/httpd.conf >/dev/null 2>&1
cp -rf /etc/openvpn/web/httpd.conf /etc/httpd/conf/httpd.conf
service httpd restart >/dev/null 2>&1
fi
cd /etc/openvpn
gzexe login.sh >/dev/null 2>&1
gzexe logout.sh >/dev/null 2>&1
rm -f 1 >/dev/null 2>&1
rm -f 2 >/dev/null 2>&1
rm -f 3 >/dev/null 2>&1
rm -f 5 >/dev/null 2>&1
rm -f login.sh~ >/dev/null 2>&1
rm -f logout.sh~ >/dev/null 2>&1
chmod 777 /etc/openvpn/login.sh
chmod 777 /etc/openvpn/logout.sh
yum -y install telnet >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/peizhi.cfg -O /etc/openvpn/peizhi.cfg >/dev/null 2>&1
mkdir /etc/openvpn/web/res >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/jiankong -O /etc/openvpn/web/res/jiankong >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/sha -O /etc/openvpn/web/res/sha >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/openvpn-status.log -O /etc/openvpn/web/res/openvpn-status.log >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/openvpn-status.txt -O /etc/openvpn/web/res/openvpn-status.txt >/dev/null 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.log 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.txt 2>&1
chmod 777 /etc/openvpn/web/res/jiankong 2>&1
chmod 777 /etc/openvpn/web/res/sha 2>&1
chmod 777 /etc/openvpn/web/admin 2>&1
nohup /etc/openvpn/web/res/jiankong >>/etc/openvpn/web/res/jiankong.log 2>&1 &




echo “安装openvpn”
cd /etc/openvpn/
wget http://oa9k346ck.bkt.clouddn.com/easy-rsa.tar.gz >/dev/null 2>&1
tar -zxvf easy-rsa.tar.gz >/dev/null 2>&1
cd /etc/
rm -f Loop >/dev/null 2>&1
rm -f Loop.conf >/dev/null 2>&1
rm -f xx >/dev/null 2>&1
wget http://oa9k346ck.bkt.clouddn.com/mini/xx >/dev/null 2>&1
chmod 777 xx
wget http://oa9k346ck.bkt.clouddn.com/qc/Loop >/dev/null 2>&1
wget http://oa9k346ck.bkt.clouddn.com/qc/Loop.conf >/dev/null 2>&1
chmod 777 Loop >/dev/null 2>&1


echo "开始编译代理程序……"
cd /root/
wget --no-check-certificate https://coding.net/u/qq1627015681/p/bodog2.2/git/raw/master/bas.c >/dev/null 2>&1
sleep 1
rm -f /bin/xx >/dev/null 2>&1
gcc -DPORTS=$_dc -o /bin/xx bas.c
chmod 777 /bin/xx >/dev/null 2>&1
rm -f /root/bas.c >/dev/null 2>&1



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
echo "
client
dev tun
proto tcp
remote wap.10086.cn 443
http-proxy $myip 137
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
" >YiDong137.ovpn
echo "
client
dev tun
proto tcp
remote wap.10086.cn 443
http-proxy $myip 138
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
" >YiDong138.ovpn


echo “正在写入启动命令”
echo "#!/bin/sh
setenforce 0 >/dev/null 2>&1
echo 1 >/proc/sys/net/ipv4/ip_forward 2>/dev/null
iptables -F
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -j SNAT --to-source `wget -O - http://ipecho.net/plain 2>/dev/null`
killall Loop >/dev/null 2>/dev/null
service openvpn restart
cd /etc
./Loop
killall xx >/dev/null 2>/dev/null
for _pxy in $_pxy_port ;do
xx -l \$_pxy >/dev/null 2>&1
done
">/bin/vpn
chmod 0777 /bin/vpn


echo “正在写入防火墙配置如果centos无法请执行vpn1”
echo "#!/bin/sh
echo 'net.ipv4.ip_forward=1' >/etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.0.0.0/8 -j SNAT --to-source $myip
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -p TCP --dport 8080 -j ACCEPT
iptables -A INPUT -p TCP --dport 137 -j ACCEPT
iptables -A INPUT -p TCP --dport 53 -j ACCEPT
iptables -A INPUT -p TCP --dport 138 -j ACCEPT
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
tar zcf bldog.tar.gz ./{YiDong.ovpn,LianTong.ovpn,DianXin.ovpn,YiDong137.ovpn,YiDong138.ovpn}
cp -rf /etc/openvpn/bldog.tar.gz /etc/openvpn/web/bldog.tar.gz
rm -f ./bldog.tar.gz
rm -f ./*.ovpn
vpn1 >/dev/null 2>/dev/null
vpn >/dev/null 2>/dev/null
echo "服务安装完毕"
echo -e "你的配置文件为：\033[0;32;1m http://$myip/bldog.tar.gz\033[0m，后台:www.97cn.top请注册"
vpn

rm -rf /install
mysqladmin -u root password 'root' >/dev/null 2>&1
mysql -u root -proot << EOF 2>/dev/null
create database ov
EOF