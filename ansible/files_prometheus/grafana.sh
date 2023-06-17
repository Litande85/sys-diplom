#!/bin/bash

# Установка Grafana
wget https://dl.grafana.com/oss/release/grafana_9.2.4_amd64.deb
sudo dpkg -i grafana_9.2.4_amd64.deb
sudo apt-get install libfontconfig1 fontconfig-config fonts-dejavu-core

# Включите автозапуск и запускаем сервер Grafana:

sudo systemctl enable grafana-server 
sudo systemctl start grafana-server 
# sudo systemctl status grafana-server

# Проверьте статус подключившись на адрес: 
# https://<наш сервер>:3000
# Стандартный логин и пароль admin \ admin