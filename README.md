# CraftBook

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Версия Ruby - 3.3.6

```bash
bundle install
yarn install
bundle exec rake db:create
bundle exec rake db:migrate
```

Для запуска web-сервера и сборки клиента нужно выполнить
```bash
rails s
foreman start -f Procfile.dev
```

Для сборки клиента без запуска сервера нужно выполнить
```bash
foreman start -f Procfile.front
```
