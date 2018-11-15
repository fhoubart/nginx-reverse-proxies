# Reverse Proxy 1 - Sécurisation HTTPS

Cette configuration permet de sécuriser en HTTPS un service qui ne l'est pas. Par exemple, une application développée sur Spring Boot ou ExpressJS dans laquelle on ne s'est pas préoccupée des certificats : le service expose directement sur le port 80.

L'intérêt de cette configuration et de dissocier la gestion du certificat HTTPS du développement applicatif et de permettre de crypter simplement n'importe quel service HTTP.

## Configuration Nginx

Le fichier [default.conf](default.conf) est copié dans le dossier de configuration Nginx /etc/nginx/conf.d pour être inclus par la configuration par défaut dans le bloc `http`. Ce fichier est documenté sur les différentes directives utilisées.

## Génération des certificats autosignés

Les certificats sont générés à la construction du container par le script [gencert.sh](gencert.sh) appelé dans le Dockerfile. Ce script fait simplement un appel à la commande `openssl` pour générer les certificats autosignés.

## Construction du Container Docker

Avant de pouvoir générer les certificats, il faut installer `openssl` via `apt-get`, ce que l'on retrouve dans le Dockerfile.