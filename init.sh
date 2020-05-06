#!/bin/bash
if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  echo 'Installing...'
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

if ! [ -x "$(command -v openssl)" ]; then
  echo 'Error: openssl is not installed.' >&2
  echo 'Installing...'
  sudo apt-get update
  sudo apt-get install openssl
fi

sudo openssl req -nodes -days 3650 -x509 -newkey rsa:2048 -keyout ./private.key -out ./cert.crt -subj '/CN=www.test.com/O=My Company Name LTD./C=US'

sudo docker volume create --name=nexus-data
sudo docker-compose up -d

until curl --fail --insecure https://localhost; do
  echo "Nexus server is starting"
  echo "Wait..."
  sleep 20
done

password=$(sudo docker-compose exec nexus cat /nexus-data/admin.password)
curl -X POST -u "admin:$password" --insecure "https://127.0.0.1/service/rest/beta/repositories/docker/hosted" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"name\": \"docker_repo\", \"online\": true, \"storage\": { \"blobStoreName\": \"default\", \"strictContentTypeValidation\": true, \"writePolicy\": \"ALLOW_ONCE\" }, \"docker\": { \"v1Enabled\": false, \"forceBasicAuth\": true, \"httpPort\": 5000 }}"
sleep 5
echo "Admin password is: $password"
