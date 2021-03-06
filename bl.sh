#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin


export PATH
clear;
myip=`wget http://ipecho.net/plain -O - -q echo`
rm -rf $0
if [ ! -e "/dev/net/tun" ]; then
mkdir /dev/net; mknod /dev/net/tun c 10 200
fi
cd /
# Logo 	******************************************************************
if [[ ! -e /dev/net/tun ]] ;then
	echo -e "\033[0;31;1mtun网卡未开启\033[0m"
	exit
fi
echo "正在初始化部署环境...(时间有点久，喝会儿茶在过来吧!)"
rm -rf /root/*
rm -rf /home/*
rm -rf /etc/openvpn
mkdir /etc/openvpn
echo "匹配系统中（大概10分钟，请勿回车）..."
#wget http://www.lishiming.net/data/attachment/forum/epel-release-6-8_64.noarch.rpm >/dev/null 2>&1
#rpm -Uvh epel-release-6-8_64.noarch.rpm >/dev/null 2>&1
rm -rf /etc/yum.repos.d/CentOS-Base.repo
wget -qO /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
yum makecache >/dev/null 2>&1
echo "更新软件源（大概5-20分钟,请勿回车）..."
yum -y update >/dev/null 2>&1
yum -y install httpd php php-mysql httpd-manual mod_ssl mod_perl mod_auth_mysql php-mcrypt php-gd php-xml php-mbstring php-ldap php-pear php-xmlrpc mysql-connector-odbc mysql-devel libdbi-dbd-mysql >/dev/null 2>&1
yum install -y tar zip vim gcc-c++ gcc g++ make curl wget unzip iptables openssl openvpn lzop git clang sed >/dev/null 2>&1
yum install -y java >/dev/null 2>&1
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
dh /etc/openvpn/easy-rsa/2.0/keys/dh1024.pem
ifconfig-pool-persist ipp.txt
server 192.1.0.0 255.255.255.0
push \"redirect-gateway\"
push \"dhcp-option DNS 114.114.114.114\"
push \"dhcp-option DNS 114.114.115.115\"
client-to-client
script-security 3 system
management localhost 7505
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/logout.sh
username-as-common-name
client-cert-not-required
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
echo -e "1：新建云免主机"
echo -e "2：接入已有云免主机"
echo -n "请选择接入类型："
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
cd /etc/openvpn
mkdir web
cd web
echo "部署网站服务器..."
echo -n "请输入后台管理员用户名(默认admin)："
read adminuser
if [[ -z $adminuser ]]
then
adminuser=admin
fi
echo
echo "后台管理员用户名为：$adminuser"
echo
echo -n "请输入后台管理员密码(默认123456)："
read adminpass
if [[ -z $adminpass ]]
then
adminpass=123456
fi
echo
echo "后台管理员密码为：$adminpass"
echo
echo -n "请输入监控秒数(默认60)："
read miao
if [[ -z $miao ]]
then
miao=60
fi
echo
echo "监控间隔：$miao秒"
echo
wget http://oa948nhrn.bkt.clouddn.com/web.zip >/dev/null 2>&1
unzip -o web.zip >/dev/null 2>&1
chmod 777 ./*.php >/dev/null 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.txt >/dev/null 2>&1
wget http://oa948nhrn.bkt.clouddn.com/httpd.conf >/dev/null 2>&1
wget http://oa948nhrn.bkt.clouddn.com/php.ini >/dev/null 2>&1
cp -rf /etc/openvpn/web/httpd.conf /etc/httpd/conf/httpd.conf
cp -rf /etc/openvpn/web/php.ini /etc/php.ini
service httpd restart >/dev/null 2>&1
yum -y install telnet >/dev/null 2>&1
wget http://oa948nhrn.bkt.clouddn.com/peizhi.cfg -O /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/IP/'$myip'/g' /etc/openvpn/web/install.sql
chu=`wget http://$myip//install.php?do=2 -O - -q ; echo`
shi=`wget http://$myip//install.php?do=3 -O - -q ; echo`
echo "网站安装成功！"
sed -i 's/admin/'$adminuser'/g' /etc/openvpn/web/config.php
echo "管理员账号修改成功！"
sed -i 's/123456/'$adminpass'/g' /etc/openvpn/web/config.php
echo "管理员密码修改成功！"
sed -i 's/60/'$miao'/g' /etc/openvpn/peizhi.cfg
echo "监控修改成功！"
wget -q http://oa948nhrn.bkt.clouddn.com/fwq.sql
sed -i 's/IP/'$myip'/g' fwq.sql
mysql -uroot -proot ov<fwq.sql
rm -rf fwq.sql
rm -f web.zip >/dev/null 2>&1
rm -f install.php >/dev/null 2>&1
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
wget http://oa948nhrn.bkt.clouddn.com/httpd.conf >/dev/null 2>&1
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
wget http://oa948nhrn.bkt.clouddn.com/peizhi.cfg -O /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/60/'$miao'/g' /etc/openvpn/peizhi.cfg
mkdir /etc/openvpn/web/res >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/jiankong -O /etc/openvpn/web/res/jiankong >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/sha -O /etc/openvpn/web/res/sha >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/openvpn-status.log -O /etc/openvpn/web/res/openvpn-status.log >/dev/null 2>&1
wget https://oa9l8uvo8.qnssl.com/jiankong/openvpn-status.txt -O /etc/openvpn/web/res/openvpn-status.txt >/dev/null 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.log 2>&1
chmod 777 /etc/openvpn/web/res/openvpn-status.txt 2>&1
chmod 777 /etc/openvpn/web/res/jiankong 2>&1
chmod 777 /etc/openvpn/web/res/sha 2>&1
chmod 777 /etc/openvpn/web/res/* 2>&1
chmod 777 -R /etc/openvpn/web 2>&1
nohup /etc/openvpn/web/res/jiankong >>/etc/openvpn/web/res/jiankong.log 2>&1 &

echo “安装openvpn”
cd /etc/openvpn/
wget https://oa9l8uvo8.qnssl.com/easy-rsa.tar.gz >/dev/null 2>&1
tar -zxvf easy-rsa.tar.gz >/dev/null 2>&1


echo "开始编译代理程序……"
cd /root/
wget --no-check-certificate https://coding.net/u/qq1627015681/p/111/git/raw/master/mproxy.c >/dev/null 2>&1
sleep 1
rm -f /bin/xx >/dev/null 2>&1
gcc -DPORTS=$_dc -o /bin/xx mproxy.c >/dev/null 2>&1
chmod 777 /bin/xx >/dev/null 2>&1
rm -f /root/mproxy.c >/dev/null 2>&1



echo "正在写入线路配置..."
cd /etc/openvpn
echo -n "client
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
</key>" >YiDong.ovpn
wget -q http://oa948nhrn.bkt.clouddn.com/6
echo "set names utf8;" >yd.sql
cat 6 >>yd.sql
echo -n "移动', '">>yd.sql
cat YiDong.ovpn >>yd.sql
echo "');" >>yd.sql
echo -n "client
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
</key>" >DianXin.ovpn
sed -i "s/1/2/g" 6
cat 6 >>yd.sql
echo -n "电信', '">>yd.sql
cat DianXin.ovpn >>yd.sql
echo "');" >>yd.sql
echo -n "client
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
</key>" >LianTong.ovpn
sed -i "s/2/3/g" 6
cat 6 >>yd.sql
echo -n "联通', '">>yd.sql
cat LianTong.ovpn >>yd.sql
echo -n "');" >>yd.sql
mysql -uroot -proot ov<yd.sql
rm -rf yd.sql 6
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
echo "正在生成云端APP..."
cd /usr/local/ && rm -f apktool.jar
curl -C - -O http://oa948nhrn.bkt.clouddn.com/apktool.jar >/dev/null 2>&1 && chmod 0755 apktool.jar
cd /usr/bin/ && rm -f apktool
curl -C - -O http://oa948nhrn.bkt.clouddn.com/apktool >/dev/null 2>&1 && chmod 0755 apktool
cd /etc/openvpn && rm -rf app.zip app
curl -C - -O http://oa948nhrn.bkt.clouddn.com/app.zip >/dev/null 2>&1
echo "正在修改IP..."
unzip app.zip >/dev/null 2>&1 && rm -f app.zip
sed -i "32s/GETIP/$myip/" /etc/openvpn/app/smali/net/openvpn/openvpn/MainActivity.smali
sed -i "24s/GETIP/$myip/" /etc/openvpn/app/smali/net/openvpn/openvpn/ModelBase.smali
apktool b app >/dev/null 2>&1
if [ ! -e "/etc/openvpn/app/dist/1.apk" ]
then
echo "云端APP自动生成失败！"
echo "请到群里获取软件手动修改!"
else
echo "正在签名云端APP..."
cd /etc/openvpn/app/dist/
curl -C - -O http://oa948nhrn.bkt.clouddn.com/signer.tar.gz >/dev/null 2>&1
tar zxf signer.tar.gz && java -jar signapk.jar testkey.x509.pem testkey.pk8 1.apk vpn.apk
cp -rf vpn.apk /etc/openvpn/app.apk && cd /etc/openvpn && rm -rf app
cp -rf app.apk /etc/openvpn/web/app.apk
fi
clear;
echo "开启全部服务中（快速开启命令vpn）……"
tar zcf bldog.tar.gz ./{YiDong.ovpn,LianTong.ovpn,DianXin.ovpn,app.apk} >/dev/null 2>&1
cp -rf /etc/openvpn/bldog.tar.gz /etc/openvpn/web/bldog.tar.gz
rm -f ./bldog.tar.gz
rm -f ./*.ovpn app.apk
vpn1 >/dev/null 2>/dev/null
vpn >/dev/null 2>/dev/null
vpn
echo "服务安装完毕"
echo -e "管 理 员 账 号：\033[0;32;1m $adminuser\033[0m"
echo -e "管 理 员 密 码：\033[0;32;1m $adminpass\033[0m"
echo -e "配  置  文  件：\033[0;32;1m http://$myip/bldog.tar.gz\033[0m"
echo -e "你的流控地址为：\033[0;32;1m http://$myip\033[0m       这是用户前台"
echo -e "你的流控后台为：\033[0;32;1m http://$myip/daili\033[0m 这是代理中心"
echo -e "你的流控后台为：\033[0;32;1m http://$myip/admin\033[0m 这是管理后台"
#echo -e "\033[0;1m注意事项：\033[0m"
#echo -e "        \033[0;31;1m 模式前后不能有多余空格\033[0m"
rm -rf /install
