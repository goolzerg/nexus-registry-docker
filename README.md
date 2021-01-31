## Description
Dockerized Nexus repository with nginx as a reverse proxy with TLS.

## Prerequisites
- Debian/Ubuntu
- Docker and docker-compose 
- Openssl

## Installation
```
chmod +x init.sh
./init.sh
```

Script automatically creates SSL self-signed certificate.
After installation nexus will have a created docker hosted repository on port 5000.
UI is accessiable via localhost:443.

## Push/Pull images

At first image must be tagged:
```
docker tag <image id> localhost:5000/<tag>
```
Then we can push it
```
docker push localhost:5000/<tag>
```
or pull
```
docker pull localhost:5000/<tag>
```
