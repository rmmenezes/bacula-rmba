#!/bin/bash
echo "Desativando o SELINUX"
setenforce 0

echo "Instalando o nano"
sudo yum install -y nano

echo "Instalando bacula no Centos"
sudo yum install -y bacula-director bacula-storage bacula-console bacula-client mariadb-server

echo "Iniciando serviço do mariabd (Mysql)"
sudo systemctl start mariadb

/usr/libexec/bacula/grant_mysql_privileges
/usr/libexec/bacula/create_mysql_database -u root
/usr/libexec/bacula/make_mysql_tables -u bacula

mysql -e "UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"

mysql --user="root" --password="password" --execute="UPDATE mysql.user SET Password=PASSWORD('bacula') WHERE User='bacula';"
mysql --user="root" --password="password" --execute="FLUSH PRIVILEGES;"

echo "Habilitando serviço do mariabd (Mysql)"
sudo systemctl enable mariadb

echo "Escolher o MySql como padrao (1)"
alternatives --set libbaccats.so /usr/lib64/libbaccats-mysql.so


echo "Instalando o Baculum"
rpm --import http://www.bacula.org/downloads/baculum/baculum.pub

echo "[baculumrepo]
name=Baculum CentOS repositoryr
baseurl=http://www.bacula.org/downloads/baculum/stable/centos8
gpgcheck=1
gpgkey=http://www.bacula.org/downloads/baculum/baculum.pub
enabled=1" > /etc/yum.repos.d/baculum.repo

yum install -y baculum-common baculum-api baculum-api-httpd baculum-web baculum-web-httpd -y
yum install baculum-api-selinux -y

echo "Defaults:apache "'!'"requiretty
apache  ALL=NOPASSWD:  /usr/sbin/bconsole
apache  ALL=NOPASSWD:  /usr/sbin/bdirjson
apache  ALL=NOPASSWD:  /usr/sbin/bsdjson
apache  ALL=NOPASSWD:  /usr/sbin/bfdjson
apache  ALL=NOPASSWD:  /usr/sbin/bbconsjson" > /etc/sudoers.d/baculum

chown -R apache /opt/bacula/etc

firewall-cmd --permanent --zone=public --add-port=9095-9096/tcp
firewall-cmd --reload

systemctl restart httpd

# cria os pontos de montagem e liberar permiçao
mkdir /backup
mkdir /restored
chmod 777 /backup
chmod 777 /restored

