FROM nginx:latest

RUN apt-get update && \
    apt-get install openssl && \
    mkdir /etc/nginx/ssl && \
    openssl req -nodes -days 3650 -x509 -newkey rsa:2048 -keyout /etc/nginx/ssl/private.key -out /etc/nginx/ssl/cert.crt -subj '/CN=www.test.com/O=My Company Name LTD./C=US' && \
    chown nginx:nginx /etc/nginx/ssl/private.key
