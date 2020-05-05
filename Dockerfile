FROM nginx
COPY nginx/* /etc/nginx/conf.d/
COPY cert.crt private.key /etc/nginx/
