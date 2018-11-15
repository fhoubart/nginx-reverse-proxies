#!/bin/sh

echo "Generating certificates..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=localhost' -keyout /etc/nginx/certs/key.pem -out /etc/nginx/certs/cert.pem
