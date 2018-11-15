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

