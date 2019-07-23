```
docker-compose docker-compose build --no-cache --pull --parallel --force-rm
docker-compose run -u root backend bundle
docker-compose run frontend yarn
# need to execute by root at backend: chmod 777 -rR ./
docker-compose run backend bin/rails db:create
```
