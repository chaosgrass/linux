#������׼����
#�������װ: VMWare+CentOS7
#���ô��̷���: INSTALLATION DESTINATION
#��������: Network&HostName: IP 192.168.80.129
#          Ҳ����ʹ��: nmtui + service network restart��������
#����root���룬�����ͨ�û�
yum -y install wget
yum -y install net-tools
yum -y install tree

#����װSeafile�������� https://manual-cn.seafile.com/deploy/using_mysql.html
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

#MySQL root���� mysql_secure_installation 
#               mysql -u root -p
#                  ��������

./seafile.sh start

#Ĭ��seahub�˿�Ϊ8000
./seahub.sh start
#����admin���估����

#FAQ: �ϴ�Unknown error: SERVICE_URL�����趨��ȷ��������IP

#���ʼ��������á� https://manual-cn.seafile.com/config/sending_email.html

# TODO: Windows�ͻ���Ȩ������

chown 

#seafile����������
#   ���� https://manual-cn.seafile.com/deploy/start_seafile_at_system_bootup.html�޸�/etc/rc.local
chmod +x /etc/rc.d/rc.local

chmod 550 /etc/init.d/seafile
chmod 550 /etc/init.d/seahub
chkconfig --add seafile
chkconfig --add seahub
chkconfig seahub on
chkconfig seafile on

service seafile start
service seahub start




