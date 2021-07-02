#!/bin/bash

mv /etc/bacula/bacula-fd.conf /etc/bacula/bacula-fd.conf.original
cp ./conf-files/bacula-fd.conf /etc/bacula/bacula-fd.conf

mv /etc/bacula/bacula-sd.conf /etc/bacula/bacula-sd.conf.original
cp ./conf-files/bacula-sd.conf /etc/bacula/bacula-sd.conf

mv /etc/bacula/bacula-dir.conf /etc/bacula/bacula-dir.conf.original
cp ./conf-files/bacula-dir.conf /etc/bacula/bacula-dir.conf

mv /etc/bacula/bconsole.conf /etc/bacula/bconsole.conf.original
cp ./conf-files/bconsole.conf /etc/bacula/bconsole.conf