FROM nginx:1.15.6

# Copie de la configuration Nginx
COPY default.conf /etc/nginx/conf.d

# Copie du contenu static
COPY html /usr/share/nginx/html

EXPOSE 8002
