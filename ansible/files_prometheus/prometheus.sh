#!/bin/bash

# Создаем пользователя Prometheus:
sudo useradd --no-create-home --shell /bin/false prometheus

# Скачиваем архив Prometheus:
wget https://github.com/prometheus/prometheus/releases/download/v2.40.1/prometheus-2.40.1.linux-386.tar.gz

# Распаковываем и копируем файлы в нужные дирректории:
tar xvfz prometheus-2.40.1.linux-386.tar.gz 
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo cp /home/user/prometheus-2.40.1.linux-386/prometheus  /usr/local/bin/
sudo cp /home/user/prometheus-2.40.1.linux-386/promtool  /usr/local/bin/
sudo cp -R /home/user/prometheus-2.40.1.linux-386/console_libraries /etc/prometheus
sudo cp -R /home/user/prometheus-2.40.1.linux-386/consoles /etc/prometheus
sudo cp /home/user/prometheus-2.40.1.linux-386/prometheus.yml /etc/prometheus

# Передаем права на файлы пользователю prometheus:
sudo chown -R prometheus:prometheus /etc/prometheus 
sudo chown -R prometheus:prometheus /var/lib/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

# Запускаем и проверяем результат
#/usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries

#Создаем сервис для работы с Prometheus

sudo cp /home/user/prometheus/prometheus.service /etc/systemd/system/prometheus.service

#Запуск сервиса
sudo systemctl enable prometheus
sudo systemctl start prometheus
#sudo systemctl status prometheus


#Можно проверить, что всё работает, перейдя по адресу: http://<ip_сервера>:9090

#Добавление Node Exporter в Prometheus
sudo sed -i '/9090/d' /etc/prometheus/prometheus.yml
cat /home/user/prometheus/targets | sudo tee -a /etc/prometheus/prometheus.yml

# Перезапустите Prometheus
sudo systemctl restart prometheus 

#Можно проверить, что всё работает, перейдя по адресу: http://<ip_сервера>:9090/targets