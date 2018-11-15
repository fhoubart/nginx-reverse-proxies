FROM nginx:1.15.6
# Copie de la configuration Nginx
COPY default.conf /etc/nginx/conf.d

# Installation d'openssl pour la génération des certificats
RUN apt-get update
RUN apt-get install openssl

# Création du dossier qui va héberger les certificats
RUN mkdir /etc/nginx/certs/
# Copie du script qui génère les certificats
COPY gencert.sh /root/gencert.sh
# Exécution du script pour génération des certificats
RUN /root/gencert.sh

EXPOSE 8000
