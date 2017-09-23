docker-compose stop
docker-compose rm -f
docker volume prune

echo "Copy setup config.."
cp -f docker-compose.override.yml.setup docker-compose.override.yml

docker-compose run --rm setup

sleep 5

echo "Setup complite.."

#docker-compose up -d app

#docker cp CONTAINERID:/var/www/html ./


