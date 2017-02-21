#【环境准备】
#虚拟机安装: VMWare+CentOS7
#重置磁盘分区: INSTALLATION DESTINATION
#配置网络: Network&HostName: IP 192.168.80.129
#          也可以使用: nmtui + service network restart配置网络
#设置root密码，添加普通用户
yum -y install wget
yum -y install net-tools
yum -y install tree

#【安装Seafile服务器】 https://manual-cn.seafile.com/deploy/using_mysql.html
yum -y install mariadb-server
yum -y install python-setuptools python-imaging python-ldap MySQL-python python-memcached python-urllib3

mkdir wisonic
cd wisonic

wget http://seafile-downloads.oss-cn-shanghai.aliyuncs.com/seafile-server_6.0.8_x86-64.tar.gz
tar zxvf seafile-server_6.0.8_x86-64.tar.gz
cd seafile-server_6.0.8_x86-64

./setup-seafile-mysql.sh

systemctl start mariadb
systemctl enable mariadb

#MySQL root密码 mysql_secure_installation 
#               mysql -u root -p
#                  输入密码

./seafile.sh start

#默认seahub端口为8000
./seahub.sh start
#输入admin邮箱及密码

#FAQ: 上传Unknown error: SERVICE_URL必须设定正确的域名或IP

#【邮件服务设置】 https://manual-cn.seafile.com/config/sending_email.html

# TODO: Windows客户端权限问题

chown 

#seafile开机启动：
#   按照 https://manual-cn.seafile.com/deploy/start_seafile_at_system_bootup.html修改/etc/rc.local
chmod +x /etc/rc.d/rc.local

chmod 550 /etc/init.d/seafile
chmod 550 /etc/init.d/seahub
chkconfig --add seafile
chkconfig --add seahub
chkconfig seahub on
chkconfig seafile on

service seafile start
service seahub start




