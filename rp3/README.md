# Reverse Proxy 3 - Composition d'url

Cette configuration permet de router le trafic vers différents serveurs en fonction du chemin de l'url. C'est un cas qu'on retrouve par exemple lorsque l'on veut héberger sur le même nom de domaine un front et un back. Une url à la racine irai sur le front, alors qu'une url du type `/api/*` serai routée sur le back.

Il faut bien faire attention à réécrire les urls avant de les transférer au serveur tiers : par exemple l'url `http://mondomaine.com/api/user` sera routé vers le back avec l'url `/user`, sans le `/api` qui est juste là pour gérer le routage.

## Configuration Nginx

La particularité de cette configuration ([default.conf](default.conf)) est la réécriture des urls pour supprimer le `/s1` ou `/s2` avant d'envoyer au serveur tier.

Cela est réalisé par les directive `rewrite`. Elles sont exécutées simultanement dans leur ordre de présence, on peut néanmoins les arrêter avec le flag `break`. Dans ce cas particulier ce n'est pas indispensable puisque les deux règles ne peuvent pas entrer en conflit.

```
location /s2 {
    rewrite /s2 / break;
    rewrite /s2/(.*) $1 break;
    proxy_pass http://server2:8080/;
}
```

La première directive remplace simplement le chemin exact `/s2` par `/`. La seconde remplace tout chemin qui commence par `/s2/` par ce qui est entre parenthèse, donc tout ce qui suit. Les variables spéciales `$1`, `$2`, etc font référence aux premier, deuxième, ... blocs entre parenthèse dans le chemin initial.

