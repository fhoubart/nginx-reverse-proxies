# Reverse Proxy 2 - Routage en fonction du Serveur Name

Cette configuration permet de router le trafic vers différents serveurs en fonction du nom de domaine utilisé. Utile par exemple dans le cas où l'on ne possède qu'une seule adresse IP publique sur laquelle on souhaite publier plusieurs applicatifs. Différents noms de domaines seront résolus en une même adresse IP par le DNS, puis un unique Reverse Proxy routera les flux sur des applications différentes.

## Configuration Nginx

La particularité de cette configuration ([default.conf](default.conf)) est d'avoir deux blocs `server` chacun avec une directive `server_name` différente. C'est cette directive qui indique à quel nom de domaine s'applique la configuration.
