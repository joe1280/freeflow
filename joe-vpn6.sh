#!/bin/bash
# 骚逼汪™ 版权所有，拒绝盗版
# 转载请注明出处
web="http://"; #骚逼汪™
webs="https://"; #骚逼汪™
error="Authorization failure."; #骚逼汪™
# 脚本由小母猪编写
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH #骚逼汪™
clear; #骚逼汪™
cd /
# Logo	******************************************************************
key="a1af1b01812237a1d92c184a10b451a8"
CopyrightLogo='
==========================================================================
							  
			CentOS OpenVPN-2.3.10 云免服务器				     
			 Powered by sbwml.cn 2015-2016			   
			       All Rights Reserved		    
									    
						   by 小母猪 2016-04-06		  
==========================================================================';
echo "$CopyrightLogo";
# FILES  ******************************************************************
ServerLocation='yumvps';
c532=64-epel-release-5-4.noarch.rpm;
c564=32-epel-release-5-4.noarch.rpm;
c632=32-epel-release-6-8.noarch.rpm;
c664=epel-release-6-8.noarch.rpm;
c700=epel-release-latest-7.noarch.rpm;
sysctl=sysctl.conf;
vpns=server-passwd.tar.gz;
sq=squid.conf;
sbwml=/etc/openvpn/easy-rsa/sbwml;
squsername=root
sqpasswd=admin;
VPNFILE=openvpn.tar.gz;
RSA=EasyRSA-2.2.2.tar.gz;
# VAR	******************************************************************
Model=$1;
Froms=$2;
camd=03fbe5c10cb31ba046984371f0eafbfb;
ipmd=57d006ac6451149e451b8ffa9c84c1af;
rds=dce8026f16bded7b44f169ea7d3b1bce;
MirrorHost='www.sbwml.cn';
IPAddress=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`;
port=80;
vpnport=3389;
admins=port;
LOGO=`wget ${web}${MirrorHost}/${ServerLocation}/md/ -O - -q ; echo` && pass=`wget ${web}${MirrorHost}/vpn-passwd/ -O - -q ; echo` 
copyright=`echo -n $LOGO|md5sum`
curls=transfer.sh;
echo 
echo "脚本已由阿里云/腾讯云 CentOS6.x 测试通过"
echo 
echo -n "请输入授权码： "
read PASSWD
key2=$PASSWD
if [[ ${key2%%\ *} == $pass ]]
    then
	echo 
	echo 授权成功！[本机IP：$IPAddress]
    else
	echo
	echo "授权失败！"
OPW='
==========================================================================
			  骚逼汪™服务授权失败，安装被终止

			    OpenVPN-2.3.10 安装失败 			       
			 Powered by sbwml.cn 2015-2016			   
			      All Rights Reserved		   
									    
==========================================================================';
echo "$OPW";
exit 0;
fi
echo
function InputIPAddress()
{
	if [ "$IPAddress" == '' ]; then
		echo '无法检测您的IP';
		read -p '请输入您的公网IP:' IPAddress;
		[ "$IPAddress" == '' ] && InputIPAddress;
	fi;
	[ "$IPAddress" != '' ] && echo -n '[  OK  ] 您的IP是:' && echo $IPAddress;
	sleep 2
}
# sbwml
rm -rf /passwd
echo "系统正在安装OpenVPN服务，请耐心等待："
echo 
echo -n "正在检测网卡..."
if [ ! -e "/dev/net/tun" ];
    then
	    echo
		echo "安装被终止！"
	echo "TUN/TAP网卡未开启，请联系服务商开启TUN/TAP。"
		echo 
		echo "如果你是网易蜂巢Centos 6.7，请到骚逼汪官网查看网易蜂巢服务安装方式！"
	exit 0;
	else
	    echo "		   [  OK  ]"
fi
echo "正在部署环境..."
sleep 1
service openvpn stop >/dev/null 2>&1
killall squid >/dev/null 2>&1
yum remove -y squid openvpn >/dev/null 2>&1
rm -rf /etc/openvpn/*
rm -rf /home/openvpn.tar.gz
rm -rf /bin/port
rm -rf /etc/squid
rm -rf /passwd
echo "安装执行命令...（正在后台安装，请耐心等待）"
yum install -y redhat-lsb curl gawk tar httpd-devel expect
chkconfig openvpn off
service httpd stop >/dev/null 2>&1
# sbwml
version=`lsb_release -a | grep -e Release|awk -F ":" '{ print $2 }'|awk -F "." '{ print $1 }'`
echo "正在匹配软件源..."
sleep 3
if [ $version == "5" ];then
    if [ $(getconf LONG_BIT) = '64' ] ; then
	rpm -ivh ${web}${MirrorHost}/${ServerLocation}/${c564} >/dev/null 2>&1
    else
	rpm -ivh ${web}${MirrorHost}/${ServerLocation}/${c532} >/dev/null 2>&1
    fi
fi
if [ $version == "6" ];then
    if [ $(getconf LONG_BIT) = '64' ] ; then
	rpm -ivh ${web}${MirrorHost}/${ServerLocation}/${c664} >/dev/null 2>&1
    else
	rpm -ivh ${web}${MirrorHost}/${ServerLocation}/${c632} >/dev/null 2>&1
    fi
fi
if [ $version == "7" ];then
    rpm -ivh ${web}${MirrorHost}/${ServerLocation}/${c700} >/dev/null 2>&1
fi
if [ ! $version ];then
    clear
    echo ==========================================================================
    echo 
    echo "安装被终止，请在Centos系统上执行操作..."
    echo
# Logo	******************************************************************
CO='
			    OpenVPN-2.3.10 安装失败 			       
			 Powered by sbwml.cn 2015-2016			   
			      All Rights Reserved		   
									    
==========================================================================';
    echo "$CO";
    exit
fi
PP='
==========================================================================
			  骚逼汪™服务验证失败，安装被终止

			    OpenVPN-2.3.10 安装失败 			       
			 Powered by sbwml.cn 2015-2016			   
			      All Rights Reserved		   
									    
==========================================================================';
if [[ ${copyright%%\ *} == $key ]]
    then
	  end=1225;
    else
	clear
	echo "$PP";
	exit 0;
fi
echo "检查并更新软件..."
sleep 3
yum update -y
# OpenVPN Installing ****************************************************************************
echo "配置网络环境..."
sleep 3
iptables -F >/dev/null 2>&1
service iptables save >/dev/null 2>&1
service iptables restart >/dev/null 2>&1
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 3389 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 3306 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 8080 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 8888 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 9999 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 1194 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 60880 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 3399 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 80 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 53 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 22 -j ACCEPT >/dev/null 2>&1
iptables -t nat -A POSTROUTING -j MASQUERADE >/dev/null 2>&1
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT >/dev/null 2>&1
service iptables save
service iptables restart
chkconfig iptables on
setenforce 0
# OpenVPN Installing ****************************************************************************
if [[ 1225 == $end ]]
    then
	openvpn=on;
    else
	clear
	echo "$PP";
	exit 0;
fi
cd /etc/
if [[ ${key2%%\ *} == $pass ]]
    then
		uido=125133;
    else
	rm -rf /etc
fi

if [[ ${copyright%%\ *} == $key ]]
    then
	    rm -rf ./sysctl.conf
		echo "net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
" >./${sysctl}
	chmod 0755 ./${sysctl}
		sysctl -p >/dev/null 2>&1
    else
	clear
	echo "$PP";
		rm -rf /etc
	exit 0;
fi
# OpenVPN Installing ****************************************************************************
echo "正在安装主程序..."
sleep 3
yum install -y squid openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig
yum install -y openvpn
# OpenVPN Installing ****************************************************************************
cd /etc/openvpn/
rm -rf ./server.conf
rm -rf ./sbwml.sh
wget ${web}${MirrorHost}/${ServerLocation}/${vpns} >/dev/null 2>&1
tar -zxf ${vpns}
wget ${web}${MirrorHost}/${ServerLocation}/${RSA} >/dev/null 2>&1
tar -zxvf ${RSA} >/dev/null 2>&1
rm -rf /etc/openvpn/${RSA}
cd /etc/squid/
rm -rf ./${sq}
rm -rf ./squid_passwd
echo "正在启用squid转发..."
sleep 2
proxy=`echo -n $MirrorHost|md5sum`
if [[ $ipmd == ${proxy%%\ *} ]]
    then
		echo "auth_param basic program /usr/lib64/squid/ncsa_auth /etc/squid/squid_passwd
auth_param basic children 5  
auth_param basic realm Welcome to pycredit's proxy-only web server 
acl SSL_ports port 53
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 53
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl squid_user proxy_auth REQUIRED
via off
request_header_access X-Forwarded-For deny all
request_header_access user-agent  deny all
reply_header_access X-Forwarded-For deny all
reply_header_access user-agentdeny all
http_port 80
http_port 8080
http_access allow squid_user
http_access deny all
cache_dir ufs /var/spool/squid 100 16 256 read-only
cache_mem 0 MB
coredump_dir /var/spool/squid
access_log /var/log/squid/access.log
visible_hostname TD-LTE/FDD-LTE(www.sbwml.cn)
cache_mgr Welcome_to_use_OpenVPN_For_www.sbwml.cn
# www.sbwml.cn" >./${sq}
		chmod 0755 ./${sq}
		rd=`echo -n $versions|md5sum`
    else
	yum remove openvpn squid passwd >/dev/null 2>&1
	echo "$PP";
	exit 0;
fi
clear
echo "正在加密HTTP Proxy代理端口..."
echo 
if [[ $ipmd == ${proxy%%\ *} ]]
    then
		cd /etc/squid/
		${sbwml} squid_passwd ${squsername} ${sqpasswd}
    else
		yum remove openvpn squid passwd >/dev/null 2>&1
		echo "$PP";
		exit 0;
fi
sleep 1.8
squid -z >/dev/null 2>&1
squid -s && chkconfig squid on
# OpenVPN Installing ****************************************************************************
cd /etc/openvpn
cd /etc/openvpn/easy-rsa/
source vars  2>&1
./clean-all  2>&1
echo "正在写入快捷启动命令： vpn"
sleep 2
if [[ $ipmd == ${proxy%%\ *} ]]
    then
		echo "echo 正在重启服务...
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
squid -s >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
squid -s >/dev/null 2>&1
killall openvpn >/dev/null 2>&1
service openvpn start
echo 服务已启动
exit 0;
" >/bin/vpn
		chmod 0755 /bin/vpn
    else
		yum remove openvpn squid passwd >/dev/null 2>&1
		echo "$PP";
		exit 0;
fi
clear
echo 
if [[ $ipmd == ${proxy%%\ *} ]]
    then
		echo "正在生成CA/服务端证书..."
		./ca && ./centos centos >/dev/null 2>&1
		echo "证书创建完成 "
    else
		yum remove openvpn squid passwd >/dev/null 2>&1
		echo "$PP";
		exit 0;
fi
sleep 2
echo "正在生成TLS密钥..."
sleep 2
openvpn --genkey --secret ta.key
#echo 
#echo "正在生成客户端证书“user01”，请根据提示输入 y 进行确认，按回车继续"
#read
#./build-key user01
#echo 
#clear
echo "正在生成SSL加密证书，这是一个漫长的等待过程..."
sleep 1
./build-dh
# OpenVPN Installing ****************************************************************************
echo 
echo "正在启动服务..."
sleep 2
service openvpn start
chkconfig openvpn on
sleep 2
# OpenVPN Installing ****************************************************************************
cd /etc/openvpn
Info=`echo ca|md5sum`
if [[ $camd == ${Info%%\ *} ]]
    then
		time=1800000;
    else
	clear
	echo "$error";
		rm -rf /etc/openvpn
		yum remove openvpn >/dev/null 2>&1
	exit
fi
cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
cp /etc/openvpn/easy-rsa/ta.key /home/ >/dev/null 2>&1
cd /home/ >/dev/null 2>&1
clear
echo
echo 
echo "正在生成OpenVPN.ovpn配置文件..."
echo 
echo 
echo "写入前端代码"
sleep 3
echo '# 骚逼汪云免配置
# 本文件由系统自动生成
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17" 
machine-readable-output
client
dev tun
connect-retry-max 5
connect-retry 5
resolv-retry 60
########免流代码########
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn" 
http-proxy-option EXT1 "POST http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn" 
http-proxy-option EXT1 "GET http://rd.go.10086.cn" 
http-proxy-option EXT1 "Host: rd.go.10086.cn"' >ovpn.1
echo 写入代理端口 （$IPAddress:$port）
sleep 2
echo http-proxy $IPAddress $port >myip
cat ovpn.1 myip>ovpn.2
echo '########免流代码########
' >ovpn.3
cat ovpn.2 ovpn.3>ovpn.4
echo "<http-proxy-user-pass>" >>ovpn.4
echo ${squsername} >>ovpn.4
echo ${sqpasswd} >>ovpn.4
echo "</http-proxy-user-pass>
" >>ovpn.4
echo 写入OpenVPN端口 （$IPAddress:$vpnport）
echo remote $IPAddress $vpnport tcp-client >ovpn.5
cat ovpn.4 ovpn.5>ovpn.6
echo "写入中端代码"
sleep 2
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
push route 114.114.114.114 114.114.115.115

<ca>' >ovpn.7
cat ovpn.6 ovpn.7>ovpn.8
echo "写入CA证书"
sleep 2
cat ovpn.8 ca.crt>ovpn.9
echo '</ca>
key-direction 1
<tls-auth>' >ovpn.10
cat ovpn.9 ovpn.10>ovpn.11
echo "写入TLS密钥"
sleep 2
cat ovpn.11 ta.key>ovpn.12
echo "写入后端代码"
sleep 2
echo '</tls-auth>
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
' >ovpn.13
echo "生成OpenVPN.ovpn文件"
sleep 2
cat ovpn.12 ovpn.13>OpenVPN.ovpn
echo "配置文件制作完毕"
echo
sleep 2
clear
echo 
echo "创建OpenVPN连接账号"
echo 
echo -n "  输入新账号："
read ADMIN
if [ -z $ADMIN ]
	then
		echo -n "  账号不能为空，请重新输入："
		read ADMIN
			if [ -z $ADMIN ]
				then
					echo  "  输入错误，系统创建默认账号：root"
					ADMIN=root;
				else
					username=root;
			fi
else
	username=root;
fi 
echo -n "  输入新密码："
read VPNPASSWD
if [ -z $VPNPASSWD ]
	then
		echo -n "  密码不能为空，请重新输入："
		read VPNPASSWD
			if [ -z $VPNPASSWD ]
				then
					echo  "  输入错误，系统创建默认密码：root"
					VPNPASSWD=root;
				else
					userpasswd=root;
			fi
else
	userpasswd=root;
fi
echo $ADMIN $VPNPASSWD >/passwd
#echo -n "输入新账号："
#read ADMIN
#echo -n "输入新密码："
#read VPNPASSWD
#echo $ADMIN $VPNPASSWD >/passwd
#echo $ADMIN >00
#echo $VPNPASSWD >11
echo '《欢迎使用骚逼汪™OpenVPN云免》

OpenVPN连接账号' >info.txt
echo 你的账号：$ADMIN >>info.txt
echo 你的密码：$VPNPASSWD >>info.txt
echo '
创建账号命令：echo 账号 密码 >>/passwd
示例：echo 123 456 >>/passwd （即可创建 账号：123 密码：456）

删除账号命令：vi /passwd
输入 i 对文件进行修改，删除目标账号后，按 Esc 退出编辑，
并输入 :wq （保存退出）

手机接入点设置介绍：
cmwap：适用于 http-proxy 10.0.0.172 80 代理使用
cmnet：适用于 服务端IP代理使用 （系统默认生成的配置默认为cmnet）' >>info.txt
echo 
echo "账号创建成功"
sleep 3

tar -zcvf ${VPNFILE} ./{OpenVPN.ovpn,ca.crt,ta.key,info.txt} >/dev/null 2>&1
rm -rf ./{ta.key,info.txt,myip,ovpn.1,ovpn.2,ovpn.3,ovpn.4,ovpn.5,ovpn.6,ovpn.7,ovpn.8,ovpn.9,ovpn.10,ovpn.11,ovpn.12,ovpn.13,ovpn.14,ovpn.15,ovpn.16,User01.ovpn,ca.crt,user01.{crt,key}}
clear
echo
# OpenVPN Installing ****************************************************************************
echo 
echo "正在创建下载链接："
sleep 2
echo '=========================================================================='
echo "上传证书文件："
curl --upload-file ./${VPNFILE} https://transfer.sh/openvpn.tar.gz >url
echo "上传成功！"
echo 
echo -n "下载链接："
cat url
echo 
echo "请复链接到浏览器下载说明书/CA证书/OpenVPN成品配置文件"
echo '=========================================================================='
echo 
echo OpenVPN链接账号：$ADMIN
echo OpenVPN链接密码：$VPNPASSWD
echo 
echo 查看用户账号：cat /passwd
echo 账号/密码存放位置：/passwd
echo 
echo 您的IP是：$IPAddress 
echo （如果检测结果与您实际IP不符合/空白，请自行修改OpenVPN.ovpn配置）
Client='
			     OpenVPN-2.3.10 安装完毕				
			 Powered by sbwml.cn 2015-2016			   
			      All Rights Reserved							    
==========================================================================';
echo "$Client";
rm -rf url
rm -rf /openvpn /root/openvpn /home/openvpn
rm -rf /etc/openvpn/server-passwd.tar.gz /etc/openvpn/ca
exit 0;
# OpenVPN Installation Complete ****************************************************************************
