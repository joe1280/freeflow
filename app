#!/bin/bash
iddz=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`; #绝迹
rm -rf $0
clear
echo -e "\033[1;35m==========================================================================\033[0m"
echo -e "\033[1;32m                                                                          \033[0m"
echo -e "\033[1;32m 　　　　　　　 　       Dalo  APP全自动生成程序                   \033[0m"
echo -e "\033[1;32m                                                                          \033[0m"
echo -e "\033[1;32m　　　　　　　　　　　                             \033[0m"
echo -e "\033[1;32m　　　　　　　　　　　　                               \033[0m"
echo -e "\033[1;32m                                                                          \033[0m" 
echo -e "\033[1;32m                                BY 绝迹 2016-11-25                       \033[0m"
echo -e "\033[1;35m==========================================================================\033[0m"
echo
echo -e "\033[34m脚本已由腾讯云/阿里云，centos7.0系统测试通过 \033[0m"
echo
echo -n -e "请输入验证码[joe1280.com]："
read queren
echo
if [[ $queren == 'joe1280.com' ]];
then
echo "正在准备安装dalo一键app服务..."
echo
else
echo "输入错误，退出程序."
echo
echo -e "\033[1;35m==========================================================================\033[0m"
echo -e "\033[1;32m                              如果你想安装           	                 \033[0m"
echo -e "\033[1;32m                            请重新执行该脚本	                             \033[0m"
echo -e "\033[1;35m==========================================================================\033[0m"
exit 0;
fi

echo -ne "\033[1;36m请输入你的APP名字(默认绝迹Dalo)：\033[0m"
read appname
if [ -z $appname ]
then
echo  "你的APP名字:绝迹Dalo"
appname=绝迹Dalo
else
echo "你的APP名字：$appname"
fi

echo -ne "\033[1;36m请输入你的ip地址(dalo线路的ip)：\033[0m"
read ip
if [ -z $ip ]
then
echo -ne "\033[1;35mip地址不能为空，请重新输入：\033[0m"
read ip
fi 
echo -ne "\033[1;35mip地址为：$ip\033[0m"

echo "正在安装java环境..."
echo
yum install -y java >/dev/null 2>&1 
echo "java环境安装完毕..."
echo
echo "正在创建环境，并开始打包线路..."
echo
mkdir -p /home/C:/VPNList/
cd /home/C:/VPNList/
echo "正在解压生成线路..."
echo
curl -O https://github.com/joe1280/freeflow/raw/master/xl.zip
unzip xl.zip >/dev/null 2>&1
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/全国移动.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/全国移动UDP.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/绝迹Dalo[udp].ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动融合2.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动融合1.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动-137.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动-137内蒙.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动-138百度.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动-138经典.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动安徽.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动百度.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动北京.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动飞翔.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动福建.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动甘肃.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动广东.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动广西.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动广州-贵州.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动贵州1.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动河北.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动河南.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动黑龙.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动湖南.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动吉林.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动江苏.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动江苏-深圳.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动经典.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动咪咕.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动-咪咕137.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动咪咕电视138.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动咪咕库.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动内蒙-辽宁.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动内蒙.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动宁夏.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动青海.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动融合.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动山东2.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动山西.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动陕西.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动上海.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动视屏.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动数据.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动四川.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动天津.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动跳转.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动跳转2.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动西藏.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动新疆.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动娱乐.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动云南.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动浙江.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动种子.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动种子.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/移动重庆.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/全国联通.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/全国联通1.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-17wo.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-17wo2.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通137.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-10010.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-10155.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-vip.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-wap.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-爱99.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-超市.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-盒子.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-经典.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-客户.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-空中.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-酷狗.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-魔法.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-视屏.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-虾米.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-虾米2.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/联通-阅读.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/全国电信.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/电信-爱听.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/电信-爱玩.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/电信-电视.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/电信-电信4G.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/电信-乐视.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/电信-音乐.ovpn
sed -i "s/123.123.123.123/${ip}/" /home/C:/VPNList/电信-音乐认证.ovpn
echo "线路生成完毕.."
cd /home/
echo "正在进行线路打包..."
curl -O https://github.com/joe1280/freeflow/raw/master/vpnlist.jar
chmod +x vpnlist.jar
java -jar vpnlist.jar >/dev/null 2>&1 
echo "线路打包完毕..."

echo "正在开始制作APP..."
cd /home
mkdir android
chmod 777 /home/android
cd /home/android
curl -O https://github.com/joe1280/freeflow/raw/master/apktool.jar
curl -O https://github.com/joe1280/freeflow/raw/master/a.apk
java -jar apktool.jar d a.apk >/dev/null 2>&1 
echo
sed -i 's/139.199.104.242/'${ip}'/g' /home/android/a/res/values/strings.xml
sed -i 's/花白云流/'${appname}'/g' /home/android/a/res/values/strings.xml
sed -i 's/139.199.104.242/'${ip}'/g' /home/android/a/smali/com/ip2o/flowmaster/d.smali
rm -rf /home/android/a/assets/profile.dat
cp /home/C:/VPNList/profile.dat /home/android/a/assets/profile.dat
sudo chmod +x /home/android/apktool.jar
java -jar apktool.jar b a >/dev/null 2>&1 
cd /home/android/a/dist
curl -O https://github.com/joe1280/freeflow/raw/master/signer.zip
unzip signer.zip >/dev/null 2>&1 
java -jar signapk.jar testkey.x509.pem testkey.pk8 a.apk dalo.apk
\cp -rf /home/android/a/dist/dalo.apk /home/Dalo.apk
echo -e "\033[1;31mapp制作完毕！\033[0m"
echo "正在清理环境..."
rm -rf /home/android
rm -rf /home/C:
echo "清理完毕...."
echo -e "\033[32;49;1m 正在上传APP中.....\033[0m";
sleep 1
echo -e "\033[32;49;1m 上传完毕,APP制作完成....\033[0m"
sleep 1
echo -e "\033[32;49;1m 绝迹一键DAlo从未改变,.......\033[0m"
sleep 1
echo -e "\033[32;49;1m By:绝迹.程序已就绪,[请回车]完成脚本！......\033[0m"
sleep 2
read                            
echo -e "\033[1;35m==========================================================================\033[0m" #搬运工如果你解开了
echo -e "\033[1;32m                       感谢使用Dalo一键APP制作           	         \033[0m" #希望你别改版权，
echo -e "\033[1;32m                      你的app在home文件夹：Dalo.apk           	         \033[0m" #脚本编写不易
echo -e "\033[1;脚本由Joe编写                               \033[0m" #每个字符都是一个一个输入的,
echo -e "\033[1;32m                                                      \033[0m" #由绝迹发布 花白编写~！
echo -e "\033[1;32m                                         \033[0m"
echo -e "\033[1;35m==========================================================================\033[0m"
exit 0
#绝迹