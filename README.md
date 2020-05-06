# nexus_nginx.docker
Dockerized nexus repository with nginx as a reverse proxy with TLS.

# Install

```
chmod +x init.sh
./init.sh
```

Script creates Docker hosted repository on port 5000, web starts on 443 port.
Nexus uses standart port.

# Push/Pull images

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
