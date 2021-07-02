#!/bin/bash

echo "Desativando o SELINUX"
setenforce 0

# so depois de alterar os arquivos de configuração e etc...
# Restaurar e Resetar tudo!
sudo bacula-sd -tc /etc/bacula/bacula-sd.conf
sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
sudo bacula-fd -tc /etc/bacula/bacula-fd.conf

sudo systemctl restart bacula-dir.service
sudo systemctl restart bacula-fd.service
sudo systemctl restart bacula-sd.service
sudo systemctl restart bacula*.service

sudo systemctl status bacula-dir.service
sudo systemctl status bacula-fd.service
sudo systemctl status bacula-sd.service

systemctl restart httpd