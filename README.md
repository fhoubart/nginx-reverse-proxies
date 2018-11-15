# Utilisation de ce repository

Ce repository contient des exemples de configuration Nginx pour la mise en oeuvre de Reverse Proxy, packagés sous Docker.

Comme les serveurs communiquent entre eux, ils doivent être exécutés sur le même réseau docker, ou plus simplement dans la même stack. Le fichier `docker-compose.yml` à la racine sert à cela. Pour lancer l'ensemble des images, lancer :

```
docker-compose up --build
```

Voici à quoi correspondent chacun des proxies :

- [http://localhost:8080](http://localhost:8080) : un serveur basique qui renvoie du contenu static, appelé le _serveur 1_
- [http://localhost:8081](http://localhost:8081) : un autre serveur qui renvoie du contenu static, appelé le _serveur 1_
- [https://localhost:8000](https://localhost:8000) (Reverse Proxy 1) : un Reverse Proxy qui se positionne en amont du _serveur 1_ en ajoutant une couche HTTPS
- [https://server1:8001](https://server1:8001) et [https://server2:8001](https://server2:8001) (Reverse Proxy 2, sous réserve d'avoir ajouté _server1_ et _server2_ dans le fichier host pour pointer vers localhost) : un Reverse Proxy qui se positionne en amont dEs deux serveurs et route en fonction du nom de domaine. On simule la mise en place de plusieurs services sur la même IP et le même port
- [https://localhost:8002](https://localhost:8002), [https://localhost:8002/s1](https://localhost:8002/s1) et [https://localhost:8002/s2](https://localhost:8002/s2) (Reverse Proxy 3) : un Reverse Proxy qui route vers différents serveurs en fonction du chemin de l'url
- [https://localhost:8003](https://localhost:8003) (Reverse Proxy 4) : un Load Balancer qui répartie la charge entre les serveurs 1 et 2


# Sujet

## Construction de deux serveurs basiques
Mettre en place deux serveurs Web qui écoutent respectivement sur les ports 8080 et 8081. Ils contiendront un fichier `index.html` :

```
Bienvenue sur le serveur 1
```

et

```
Bienvenue sur le serveur 2
```

Le texte différent permettra de savoir quel serveur à traité la demande dans le cas de load-balancing.

Ces deux serveurs sont paramétrés dans les dossiers [server1](server1) et [server2](server2).

## Reverse Proxy 1 : sécurisation par HTTPS

Montez sur le port 8000 un Reverse Proxy qui renvoie tout le traffic vers le serveur 1.
Modifier ensuite le paramétrage pour que le port 8000 soit en https, avec un certificat autosigné.

Cette configuration est disponible dans le dossier [rp1](rp1).

On a ici le cas de figure classique où l'on dissocie le développement fonctionnel et l'intégration du service. L'applicatif peut tourner sur n'importe quelle technologie (Spring Boot, ExpressJS, ...) et on ne se soucie pas du cryptage et des certificats. Lors de l'intégration, la sécurisation est faite sur le Reverse Proxy.

## Reverse Proxy 2 : routage en fonction du serverName
Montez maintenant sur le port 8001 un Reverse Proxy qui va en fontion du nom de domaine de la requête router vers le bon serveur :

  - http://server1/ => vers le serveur 1
  - http://server2/ => vers le serveur 2

Vous pouvez pour simuler le DNS ajouter ces deux entrées dans vos fichiers host.

Cette configuration est disponible dans le dossier [rp2](rp2).

On a ici le cas de figure classique d'une unique IP publique qui arrive sur un seul Reverse Proxy qui ventile les flux sur plusieurs applicatifs différents.

## Reverse Proxy 3 : Composition d'url

Monter sur le port 8001 un reverse proxy qui va router le trafic en fonction de l'url vers le bon serveur :

  - sur l'url /, renvoie le message statique "Bonjour du reverse proxy", directement du reverse proxy
  - sur l'url /s1, renvoie le trafic vers le serveur 1
  - sur l'url /s2, renvoie le trafic vers le serveur 2

Cette configuration est disponible dans le dossier [rp3](rp3).

Ce genre de mécanisme peut être utilisé par exemple pour router le / vers un front static en Angular, et des urls particulières, comme /api, vers un backend sur une autre technologie (Java, PHP, NodeJS, ...).

## Reverse Proxy 4 : Load Balancer

Montez maintenant sur le port 8002 un reverse proxy qui va jouer le rôle de load balancer entre les serveurs 1 et 2. Testez les différents algos de répartitions différents et regardez comment ils se comportent

Cette configuration est disponible dans le dossier [rp4](rp4).

