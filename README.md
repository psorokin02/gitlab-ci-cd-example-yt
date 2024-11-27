# Настройка Gitlab CICD для проекта

### Запуск раннера
Запускаем раннер в docker контейнере
```
docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:alpine
```

### Регистрация раннера
Выполняем внутри контейнера с запущенным раннером команду регистрации раннера
```
docker exec -it gitlab-runner gitlab-runner register
```

Указываем параметры раннера
```
Enter the GitLab instance URL (for example, https://gitlab.com/): https://gitlab.com/
Enter the registration token: ВАШ токен
Enter an executor: docker
Enter the default Docker image (for example, ruby:2.7): docker:dind
```

### Изменение конфига 
Заходим в режим редактирования конфига
```
nano /srv/gitlab-runner/config/config.toml
```

Находим строчку
```
volumes = ["/cache"]
```
Удаляем строчку и меняем строчку на новую.
Это позволит раннеру джобам запускать контейнеры в docker
```
volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
network_mode = "host"
```
