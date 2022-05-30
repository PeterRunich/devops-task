### Для корректной работы у вас должны быть установлены
- docker
- ansible
- nodeJS v.14.17.5
- yarn v.1.22.11
- git
- ssh

### Docker
Ваш пользователь должен быть в группе docker, чтобы использовать docker без sudo
https://github.com/sindresorhus/guides/blob/main/docker-without-sudo.md

### Ssh
У вас должен быть доступ к серверу по ssh через ключ

### Инструкция
1. Скопируйте данный репозиторий - git clone https://github.com/PeterRunich/devops-task.git
2. Перейдите в репозиторий - cd devops-task
3. Откройте файл hosts.txt и укажите путь до закрытого ssh ключа в переменной ansible_ssh_private_key_file - пример: ansible_ssh_private_key_file = /путь_до_ключа
4. В файле hosts.txt отредактируйте юзера под которым заходите на сервер - пример: ansible_user = vasya, так же укажите ssh порт в перемнной ansible_port, если он не стандартный
5. Запустите bundle.sh находясь в той же папке где и скрипт

По вопросам, tg: @PRunich
