#!/bin/bash
rm -rf ssr.sh
hmd=c4ca4238a0b923820dcc509a6f75849b;
web="http://"; 
webs="https://"; 
error="Authorization failure."; 
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH 
clear; 
cd /
# Logo	******************************************************************
CopyrightLogo='
==========================================================================
				         欢迎使用
							  
				ShadowSocks多用户管理系统v2版

				采用SSR+ss-panel2流控管理系统
		
							Powered by 铭哥 2016
							
					授权地址http://tss9.cn/ss
		   
							All Rights Reserved
							
				我们的官方网站 http://tss9.cn
		 
									    
	              	
==========================================================================';
echo "$CopyrightLogo";
# VAR	******************************************************************
MirrorHost='tss9.cn';
IPAddress=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`;
ServerLocation=3306;
sq=1;
#==========================================================================
echo 
echo "脚本支持【centos6.x】系统(如遇到卡住，请耐心等待5-7分钟)"
echo 
echo -n "[本机IP：$IPAddress]：请到 http://tss9.cn/ss/  进行授权，已授权请回车 "
read 
KSH=1;
if [ "$KSH" = "1" ] ;then
	echo 
	echo 授权成功！[本机IP：$IPAddress]
    else
	echo
	echo "授权失败！"
OPW='
==========================================================================
			 服务授权失败，安装被终止
			
			可能原因是您的ip未被授权
			
			授权地址http://tss9.cn/ss/
 
			ShadowSocks多用户管理系统安装失败 			       
			      Powered by 铭哥 2016
			         
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
# 铭哥最帅
echo -n "请输入数据库密码(默认root)： "
read mysqlpass
if [ -z $mysqlpass ]
then
echo  "数据库密码：root"
mysqlpass=root
else
        echo "数据库密码：$mysqlpass"
        fi
        echo -n "请输入后台登陆账号，请使用邮箱方式(默认admin@qq.com)： "
read gly
if [ -z $gly ]
then
echo  "后台账号：admin@qq.com"
gly=admin@qq.com
else
        echo "后台账号：$gly"
        fi
        echo -n "请输入SS连接端口，(默认138)： "
read proxy
if [ -z $proxy ]
then
echo  "SS连接端口：138"
proxy=138
else
        echo "SS连接端口：$proxy"
        fi
        echo -n "请输入SS连接密码密码，(默认ss2016)： "
read sspass
if [ -z $sspass ]
then
echo  "SS连接密码：ss2016"
sspass=ss2016
else
        echo "SS连接密码：$sspass"
        fi
        sleep 2
echo "正在部署环境..."
yum install -y git redhat-lsb curl gawk tar httpd-devel unzip sharutils sendmail expect
yum install wget tar gcc gcc-c++ openssl openssl-devel pcre-devel python-devel libevent automake autoconf libtool make -y
# 铭哥最帅
CO='
==========================================================================
			安装被终止,请在Centos 6 系统上执行操作
 
			ShadowSocks多用户管理系统安装失败 			       		       
			     Powered by 铭哥 2016			         
				        All Rights Reserved	
				我们的官方网站 http://tss9.cn
					   
					
==========================================================================';
version=`lsb_release -a | grep -e Release|awk -F ":" '{ print $2 }'|awk -F "." '{ print $1 }'`
if [ $version == "6" ];then
rpm -ivh ${web}${MirrorHost}/${ServerLocation}/epel-release-6-8.noarch.rpm  >/dev/null 2>&1
rpm -ivh ${web}${MirrorHost}/${ServerLocation}/remi-release-6.rpm  >/dev/null 2>&1
fi
if [ $version == "7" ];then
echo 
    echo "安装被终止，请在Centos6系统上执行操作..."
	echo "$CO";
exit
fi
if [ ! $version ];then
    echo 
    echo "安装被终止，请在Centos系统上执行操作..."
	echo "$CO";
exit
fi
sleep 1
yum update -y
# SSR Installing ****************************************************************************
echo "配置网络环境..."
sleep 3
iptables -F >/dev/null 2>&1
service iptables save >/dev/null 2>&1
service iptables restart >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 3389 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 3306 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 138 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 137 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 9999 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 1194 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 60880 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 3399 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 80 -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p TCP --dport 22 -j ACCEPT >/dev/null 2>&1
service iptables save
service iptables stop
chkconfig iptables off
# SSR Installing ****************************************************************************
echo "开始安装LAMP环境" 
yum -y install httpd 
chkconfig httpd on
/etc/init.d/httpd start
yum remove -y mysql*
yum --enablerepo=remi install -y mysql mysql-server mysql-devel
chkconfig mysqld on 
service mysqld start
yum remove -y php*
yum install -y --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof php-bcmath php-cli php-common  php-devel php-fpm    php-gd php-imap  php-ldap php-mysql  php-odbc  php-pdo  php-pear  php-pecl-igbinary  php-xml php-xmlrpc php-opcache php-intl php-pecl-memcache
service php-fpm start
service httpd restart
cd /var/www/html
echo "正在下载lamp环境源..."
wget ${web}${MirrorHost}/${ServerLocation}/phpmyadmin.zip >/dev/null 2>&1
unzip phpmyadmin.zip >/dev/null 2>&1 
rm -f phpmyadmin.zip
service php-fpm restart
service httpd restart
service mysqld restart
rm -rf /bin/lamp
echo "#!/bin/sh
echo 正在重启lamp服务...
service mysqld restart 
service php-fpm restart 
service httpd restart
echo 服务已启动
exit 0;
" >/bin/lamp
		chmod 0777 /bin/lamp
		service sendmail restart
# SSR Installing ****************************************************************************
cd /root
yum -y install m2crypto python-setuptools
easy_install pip
pip install cymysql
wget ${web}${MirrorHost}/${ServerLocation}/SSR.zip >/dev/null 2>&1
unzip SSR.zip >/dev/null 2>&1
cd shadowsocks
cp apiconfig.py userapiconfig.py
cp mysql.json usermysql.json
cp config.json user-config.json
sed -i "5s/123456/$mysqlpass/" /root/shadowsocks/usermysql.json >/dev/null 2>&1
cd /root
mysqladmin -u root password $mysqlpass 
mysql -uroot -p$mysqlpass -e"CREATE DATABASE shadowsocks;" 
cd /var/www/html
wget ${web}${MirrorHost}/${ServerLocation}/ss-panel.zip >/dev/null 2>&1
unzip ss-panel.zip >/dev/null 2>&1
rm -rf ss-panel.zip
cd lib/
cp config-simple.php config.php
sed -i "16s/password/$mysqlpass/" /var/www/html/lib/config.php >/dev/null 2>&1
sed -i "33s/first@blood.com/$gly/" /var/www/html/sql/user.sql
sed -i "33s/LoveFish/$sspass/" /var/www/html/sql/user.sql
sed -i "33s/10000/$proxy/" /var/www/html/sql/user.sql
cd /var/www/html/sql
mysql -uroot -p$mysqlpass shadowsocks < invite_code.sql
mysql -uroot -p$mysqlpass shadowsocks < ss_node.sql
mysql -uroot -p$mysqlpass shadowsocks < ss_reset_pwd.sql
mysql -uroot -p$mysqlpass shadowsocks < ss_user_admin.sql
mysql -uroot -p$mysqlpass shadowsocks < user.sql
echo "正在启动SSR服务" 
sleep 1
cd /root/shadowsocks/tests/
bash test.sh >/dev/null 2>&1
cd /root/shadowsocks
chmod +x *.sh
./logrun.sh
chmod +x /etc/rc.d/rc.local
chmod +x /root/shadowsocks/tests/test
echo "/root/shadowsocks/run.sh" >/etc/rc.d/rc.local
rm -rf /bin/SSR
rm -rf /root/shadowsocks/tests/test.sh
echo "#!/bin/sh
echo 正在重启SSR服务...
/root/shadowsocks/stop.sh
/root/shadowsocks/run.sh
echo 服务已启动
exit 0;
" >/bin/SSR
		chmod 0777 /bin/SSR
# SSR Installing ****************************************************************************
echo 
echo '=========================================================================='
echo
echo 恭喜！您的SSR服务已启动
echo
echo 一起欢呼铭哥最帅！
echo
echo 数据库地址：http://$IPAddress/phpmyadmin
echo
echo 用户地址：http://$IPAddress/
echo
echo 管理后台：http://$IPAddress/admin
echo 
echo 你的数据库账号：root
echo
echo 你的数据库密码：$mysqlpass
echo 
echo 你的后台账号：$gly
echo
echo 你的后台密码：1993
echo
echo 连接端口：$proxy
echo
echo 连接密码：$sspass
echo
echo 本地端口：1080
echo
echo 加密方式：aes-256-cfb
echo
echo 协议：auth_sha1
echo
echo 混淆方式：http_simple
echo
echo lamp快捷重启命令：lamp
echo 
echo SSR快捷重启命令：SSR
echo 
echo 您的IP是：$IPAddress 
echo 
echo 我们的官方网站 http://tss9.cn
Client='
==========================================================================
			ShadowSocks多用户管理系统安装完毕
			
			         Powered by 铭哥 2016
			   
			            All Rights Reserved		    
			
			我们的官方网站 http://tss9.cn
									    
	              							    
==========================================================================';
echo "$Client";
exit 0;
# SSR Installation Complete ****************************************************************************