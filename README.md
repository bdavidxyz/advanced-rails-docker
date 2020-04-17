# Advanced Rails 6 + docker-compose project

This repository is intended to be a professional starter kit for any new monolithic Rails application.

It provides a professional workflow for most Rails use case : migration, real-time, caching, mailing, etc.

It provides a way to deploy the application in production as seamlessly as possible.

## Steps to reproduce

### 0. Prerequisites

```
$> docker -v
Docker version 17.12.0-ce

$> docker-compose -v
docker-compose version 1.18.0
```

Any upper version should work.


### 1. Build images
Run :
```
docker-compose build
```

### 2. Build project

Run :
```
docker-compose run --rm web_srv bash
$> create_new_rails_app 6.0.2.2
```

It will create a new rails application with version 6.0.2.2.

the script is under .dockerdev/.bashrc. It will 

1) install rails, 
2) run the "rails new" command without bundle install and webpacker install
3) runs bundle install and webpacker install with the correct bundler version

### 3. Adapt database.yml and webpacker.yml to Docker configuration

Open and change config/database.yml
```
default: &default
  host: db_srv # <---- add this property
  username: myuser # <---- add this property
```

### 4. Create hello world page

Run :
```
docker-compose run --rm --no-deps web_srv rails generate controller hello say_hello
``` 

Flag explanations:
* **--no-deps** - Tells `docker-compose run` not to start any of the services in `depends_on`.
* **--rm** - Removes container after run

### 5. Start services

```
docker-compose up
```

### 6. Visit "hello world" page

go to http://localhost:3000/hello/say_hello

 - Open the browser console to check that CSS, JS loaded correctly and no 404 request occured.
 - Check also the logs of the services in your terminal to notice that no error occured.

## Restart from scratch

removes all docker containers, images, and volumes. Warning, all data will be lost.
```
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q) -f && docker volume prune -f
```

remove all files generated by the "rails new" command
```
rm -rf -v !("Dockerfile"|".dockerenv"|".gitignore"|"README.md"|"docker-compose.yml") && rm .browserslistrc && rm .ruby-version
```

