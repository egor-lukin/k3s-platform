# K3S Platform

Код для настройки инфраструктуры на базе hetzner cloud и k3s.

## Подготовка
1. Для работы с репозиторием требуется ssh ключ, который нужно положить в ~/.ssh директорию.
2. Также требуется переименовать файл .env.example в .env и подставить актуальный токен.
3. Если кластер уже настроен, нужно добавить параметры подключения к кластеру в ~/kube/config 
4. Все дальнейшие команды делаются внутри docker контейнера, который запускается через docker-compose

## Terraform 
* Команды для terraform исполняются внутри директории /terraform/terraform/live/cluster-prod.
* Перед любыми действиями с terraform нужно залогиниться командой terraform login.

### Основные комманды
* terraform plan -var hcloud_token=$HCLOUD_TOKEN
* terraform apply -var hcloud_token=$HCLOUD_TOKEN

## Default kubernetes resources

По-умолчанию в кластер устанавливаются:
1. csi-driver - для работы с volumes
2. ingress-nginx - для роутинга трафика внутрь кластера
3. cert-manager и issuers - для работы с https сертификатами 

### Основные комманды
* helmfile diff --set hcloud_token=$HCLOUD_TOKEN --set runnerRegistrationToken=$GITLAB_TOKEN
* helmfile sync --set hcloud_token=$HCLOUD_TOKEN --set runnerRegistrationToken=$GITLAB_TOKEN
