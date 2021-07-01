#!/bin/bash
# https://www.labeightyfour.com/2019/04/08/introduction-to-bacula-how-to-install-configure-backup-and-restore/3/

# Instalar Bacula (Debian)
apt update
apt upgrade
apt install bacula -y

# cria os pontos de montagem e liberar permiçao
mkdir /backup
mkdir /restored
chmod 777 /backup
chmod 777 /restored

# so depois de alterar os arquivos de configuração e etc...
# Restaurar e Resetar tudo!
sudo bacula-sd -tc /etc/bacula/bacula-sd.conf
sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
sudo bacula-fd -tc /etc/bacula/bacula-fd.conf

sudo systemctl restart bacula-director.service
sudo systemctl restart bacula-fd.service
sudo systemctl restart bacula-sd.service
sudo systemctl restart bacula*.service

sudo systemctl status bacula-director.service
sudo systemctl status bacula-fd.service
sudo systemctl status bacula-sd.service
