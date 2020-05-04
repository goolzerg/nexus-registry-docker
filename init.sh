#!/bin/bash
if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  echo 'Installing...'
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  exit 1
fi

if ! [ -x "$(command -v openssl)" ]; then
  echo 'Error: openssl is not installed.' >&2
  echo 'Installing...'
  sudo apt-get update
  sudo apt-get install openssl
  exit 1
fi

sudo openssl req -nodes -days 3650 -x509 -newkey rsa:2048 -keyout ./private.key -out ./cert.crt -subj '/CN=www.test.com/O=My Company Name LTD./C=US'

sudo docker-compose up -d

until curl --fail --insecure https://localhost; do
  sleep 1
done

curl -X POST -u "admin:admin123" --insecure "https://127.0.0.1/service/rest/beta/repositories/docker/hosted" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"name\": \"docker_repo\", \"online\": true, \"storage\": { \"blobStoreName\": \"default\", \"strictContentTypeValidation\": true, \"writePolicy\": \"ALLOW_ONCE\" }, \"docker\": { \"v1Enabled\": false, \"forceBasicAuth\": true, \"httpPort\": 5000 }}"
sudo password=$(docker-compose exec nexus cat /nexus-data/admin.password)
echo "Admin password is: $password"
