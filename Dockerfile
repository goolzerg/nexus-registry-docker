FROM nginx
COPY ./nginx/* /etc/nginx/conf.d/nexusweb.conf
COPY cert.crt private.key /etc/nginx/
