#!/bin/sh

docker-compose stop
docker-compose rm -f
docker volume prune -f

echo "Copy setup config.."
cp -f docker-compose.override.yml.setup docker-compose.override.yml

echo "Start setup process.."
docker-compose run --rm setup

echo "Up app.."
docker-compose up -d app

echo "Copy site data to host.."
cid=$(docker-compose ps -q phpfpm)
docker cp $cid:/var/www/html ./

echo "Map host data to volumes.."
cp -f docker-compose.override.yml.dist docker-compose.override.yml
docker-compose up -d app

echo "Setup complete.."
