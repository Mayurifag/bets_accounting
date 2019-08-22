```
docker-compose build --no-cache --pull --parallel --force-rm # or docker-compose build

# created user without rights, have to 777 app folder
docker-compose run -u root frontend chmod 777 -R ./
docker-compose run -u root backend chmod 777 -R ./
docker-compose run -u root backend bundle
docker-compose run frontend yarn
docker-compose run backend bin/rails db:create
docker-compose up # -d

docker-compose run backend bundle exec rspec
```

front: localhost:3333
back: localhost:8888

bundle audit check --update
