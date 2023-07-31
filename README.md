# Laravel Template Project

Шаблон, который используется для Laravel проектов в BD.

## Howto: Использование шаблона

1) Убедитесь, что у вас установлен Docker

2) Создайте директорию, в которой вы хотите развернуть проект и войдите в нее

    ```bash
    mkdir my-app && cd my-app
    ```

3) Созайте новый проект с помощью composer:

    ```bash
    docker run --rm --interactive --tty --volume $PWD:/app composer create-project bang-digital-dev/laravel-template  .
    ```

4) Выполните авторизацию в docker registry

   Для следующего шага вам понадобится логин и пароль. Логин - это ваш username в gitlab. В качестве пароля используйте
   personal **access token** для gitlab с доступом к `read_registry`. Получить его
   можно [здесь](https://bangdig.gitlab.yandexcloud.net/-/profile/personal_access_tokens).

    ```bash
    docker login bangdig.gitlab.yandexcloud.net:5050
    ```

5) Первый запуск проекта

    - Собираем образы, запускаем контейнеры
        ```bash
        make build start
        ```
    - Инициализируем проект
        ```bash
        make init
        ```
      > **Важно!** Перед запуском скрипта инициализации проекта, убедитесь, что mysql контейнер запустился и готов к
      работе.

6) Вы великолепны!

### Бонус пункт - уставка админки

Для того, чтобы поставить админку Laravel Nova, добавьте в `composer.json`:

```
  "repositories": {
    "local-nova": {
      "type": "path",
      "url": "./packages/laravel-nova"
    }
  }
```

Далее, архив* с Laravel Nova разархивируйте в папку `./packages/laravel-nova` и выполните команду:

```bash
composer require laravel/nova
```

Затем выполните скрипты инициализации Laravel Nova:

```bash
php artisan nova:install

php artisan migrate
```

И не забудьте поправить правила доступа в админку в `\App\Providers\NovaServiceProvider::gate`:

```php
    protected function gate()
    {
        Gate::define('viewNova', function (User $user) {
            return $user->is_admin;
        });
    }
```

> *Архив можете запросите у коллег

## Локальная разработка проекта

### Доступные сервисы

- mysql
- redis
- minio
- mailhog
- swagger ui
- phpmyadmin

Порты и доступы смотрите в `docker-compose.yml`

### Доступные Makefile команды

#### build

Команда для сборки Docker-образов проекта.

```bash
make build
```

#### start

Команда для запуска Docker-контейнеров проекта.

```bash
make start
```

#### stop

Команда для остановки Docker-контейнеров проекта.

```bash
make stop
```

#### remove

Команда для полной остановки и удаления Docker-контейнеров, а также networks и volumes проекта.

```bash
make remove
```

#### init

Команда для инициализации проекта.

```bash
make init
```

#### php_sh

Команда для запуска оболочки внутри контейнера с PHP-FPM, чтобы можно было выполнить команды внутри контейнера.

```bash
make php_sh
```

#### phpstan

Команда для запуска анализатора кода phpstan

```bash
make phpstan
```
