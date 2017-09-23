#!/bin/sh

docker-compose stop
docker-compose rm -f
docker volume prune -f

echo "Copy setup config.."
cp -f docker-compose.override.yml.setup docker-compose.override.yml

echo "Start setup process.."
docker-compose run --rm setup

echo "Setup complete.."

docker-compose up -d app

echo "Copy site data to host.."
cid=$(docker-compose ps -q phpfpm)
docker cp $cid:/var/www/html ./


