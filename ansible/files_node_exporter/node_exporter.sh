#!/bin/bash

# Создаем пользователя Prometheus:
sudo useradd --no-create-home --shell /bin/false prometheus

#Скачиваем архив и распоковываем
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz 
tar xvfz /home/user/node_exporter-1.4.0.linux-amd64.tar.gz

#Копируем Node Explorer в папку Prometheus
sudo mkdir /etc/prometheus
sudo mkdir /etc/prometheus/node-exporter
sudo cp -r /home/user/node_exporter-1.4.0.linux-amd64/* /etc/prometheus/node-exporter

#Передаем права
sudo chown -R prometheus:prometheus /etc/prometheus/node-exporter/

#Создаем службу
sudo cp /home/user/node-exporter/node-exporter.service  /etc/systemd/system/node-exporter.service
sudo chown -R prometheus:prometheus /etc/prometheus/node-exporter/

#Запуск службы
sudo systemctl enable node-exporter
sudo systemctl start node-exporter
#sudo systemctl status node-exporter -d


#Можно проверить, что всё работает, перейдя по адресу: http://<ip_сервера>:9100/metrics  