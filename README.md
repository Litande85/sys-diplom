#  Дипломная работа по профессии «Системный администратор» - `Елена Махота`

Содержание
==========
* [Задача](#Задача)
* [Инфраструктура](#Инфраструктура)
* [Сайт](#Сайт)
* [Мониторинг](#Мониторинг)
* [Логи](#Логи)
* [Сеть](#Сеть)
* [Резервное копирование](#Резервное-копирование)
 
---------
## Задача
Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/).

## Инфраструктура

### *План инфраструктуры*

## *[Сеть main-network](terraform/network.tf)*

    Внутренняя подсеть для сайта 1
    Внутренняя подсеть для сайта 2
    Внутренняя подсеть для сервисов
    Публичная подсеть bastion host

## *[Группы](terraform/groups.tf)*

    Target Group
    Backend Group
    Security Groups

## *Инстансы*

[web-1](/terraform/web-1.tf) |
[web-2](terraform/web-2.tf) |
[bastion](terraform/bastion.tf) |
[load-balancer](terraform/load-balancer.tf) |
[router](terraform/router.tf)



Для развёртки инфраструктуры использован [Terraform](terraform). 

Для установки сервисов использован [Ansible](ansible).


### Сайт
Создайно две ВМ в разных зонах посредством [Terraform](terraform):[web-1](terraform/web-1.tf), [web-2](terraform/web-2.tf)

    web-1 10.1.0.10 ru-central1-a
    web-2 10.2.0.10 ru-central1-b

На них установлен сервер nginx посредством playbook ansible [web.yml](ansible/web.yml) в docker контейнере. 
ОС и содержимое ВМ идентично, это веб-сервера.

Использован  статичный файл для сайта [index.html](ansible/index.html)

Созданы [Target Group, Backend Group](terraform/groups.tf).

Создан [HTTP router](terraform/router.tf).

Создан [Application load balancer](terraform/load-balancer.tf).

Сайт открывается с публичного IP балансера

### <a href = "http://158.160.42.86/" target="_blank">http://158.160.42.86/</a>


### Мониторинг
Создайте ВМ, разверните на ней Prometheus. На каждую ВМ из веб-серверов установите Node Exporter и [Nginx Log Exporter](https://github.com/martin-helmich/prometheus-nginxlog-exporter). Настройте Prometheus на сбор метрик с этих exporter.

Создайте ВМ, установите туда Grafana. Настройте её на взаимодействие с ранее развернутым Prometheus. Настройте дешборды с отображением метрик, минимальный набор — Utilization, Saturation, Errors для CPU, RAM, диски, сеть, http_response_count_total, http_response_size_bytes. Добавьте необходимые [tresholds](https://grafana.com/docs/grafana/latest/panels/thresholds/) на соответствующие графики.

### Логи
Cоздайте ВМ, разверните на ней Elasticsearch. Установите filebeat в ВМ к веб-серверам, настройте на отправку access.log, error.log nginx в Elasticsearch.

Создайте ВМ, разверните на ней Kibana, сконфигурируйте соединение с Elasticsearch.

### Сеть
Разверните один VPC. Сервера web, Prometheus, Elasticsearch поместите в приватные подсети. Сервера Grafana, Kibana, application load balancer определите в публичную подсеть.

Настройте [Security Groups](https://cloud.yandex.com/docs/vpc/concepts/security-groups) соответствующих сервисов на входящий трафик только к нужным портам.

Настройте ВМ с публичным адресом, в которой будет открыт только один порт — ssh. Настройте все security groups на разрешение входящего ssh из этой security group. Эта вм будет реализовывать концепцию bastion host. Потом можно будет подключаться по ssh ко всем хостам через этот хост.

Доступ через бастион:

```bash
ssh -i ~/.ssh/id_rsa -J user@51.250.35.253 user@10.1.0.10

```

### Резервное копирование
Создайте snapshot дисков всех ВМ. Ограничьте время жизни snaphot в неделю. Сами snaphot настройте на ежедневное копирование.

### Использованные источники
Документация Yandex Cloud по сетям и подсетям:

* <a href = "https://cloud.yandex.ru/docs/vpc/operations/network-create" target="_blank">Создание сети</a>
* <a href = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create" target="_blank">Создание подсети</a>
* <a href = "https://cloud.yandex.ru/docs/vpc/operations/create-nat-gateway">Настройка Nat-шлюза</a>
* <a href = "https://cloud.yandex.ru/docs/vpc/operations/static-route-create">Статический маршрут</a>


Документация Yandex Cloud по Группам:

* <a href = "https://cloud.yandex.ru/docs/application-load-balancer/operations/target-group-create" target="_blank">Создать целевую группу Target Group для балансировщика</a>
* <a href = "https://cloud.yandex.ru/docs/application-load-balancer/operations/backend-group-create" target="_blank">Создать группу бэкендов Backend Group</a>
* <a href = "https://github.com/yandex-cloud/docs/blob/master/ru/vpc/operations/security-group-create.md" target="_blank">Создание Группы безопасности</a>
* <a href = "https://cloud.yandex.ru/docs/vpc/concepts/security-groups" target="_blank">Группы безопасности</a>
* <a href = "https://github.com/yandex-cloud/docs/blob/master/ru/managed-kubernetes/operations/connect/security-groups.md" target="_blank">Настройка групп безопасности</a>

Прочие:

* <a href = "https://cloud.yandex.ru/docs/cos/tutorials/coi-with-terraform" target="_blank">Создание VM с docker контенером</a>
* <a href = "https://dev.to/domysee/setting-up-a-reverse-proxy-with-nginx-and-docker-compose-29jg" target="_blank">Настройка nginx и docker-compose</a>
* <a href = "https://cloud.yandex.ru/docs/tutorials/routing/bastion" target="_blank">Создание бастиона</a>
* <a href = "https://cloud.yandex.ru/docs/application-load-balancer/operations/application-load-balancer-create" target="_blank">Создание L7-балансировщика</a>
* <a href = "https://cloud.yandex.ru/docs/application-load-balancer/operations/http-router-create" target="_blank">Создание HTTP-роутера для HTTP-трафика</a>

* <a href = "https://blog.ruanbekker.com/blog/2020/10/26/use-a-ssh-jump-host-with-ansible/" target="_blank">Использование Бастиона с Ansible</a>
