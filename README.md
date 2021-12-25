# noirgt_infra
noirgt Infra repository

# Задание 1:
> Предложить вариант решения для подключения из консоли при помощи
> команды вида ssh someinternalhost из локальной консоли рабочего
> устройства, чтобы подключение выполнялось по алиасу
> someinternalhost и внести его в README.md в вашем репозитории

Для выполнения этого задания я использовал привычную команду **ssh**, но с флагом **-J** для прыжка на второй хост через первый:
```
ssh -J 51.250.28.70 10.128.0.6
```
И для удобства подключения через алис я внёс в файл **~/.ssh/config** следующий блок конфигурации:
```
Host someinternalhost
        HostName 10.128.0.6
        ProxyJump noble@51.250.28.70:22
        User noble
```
# Задание 2:
> Описать конфигурацию и данные для подключения Pritunl

Данное задание выполнил для удобства на CentOS - думаю, это не критично. Ниже данные для подключения:
```
bastion_IP = 51.250.28.70
someinternalhost_IP = 10.128.0.6
```
# ДЗ "Деплой тестового приложения":
# Задание 1:
Данные для подключения к облачному приложению:
```
testapp_IP = 51.250.5.97
testapp_port = 9292
```
