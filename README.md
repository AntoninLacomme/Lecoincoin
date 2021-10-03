# Lecoincoin

L'application se lance en localhost:8080 ou en 127.0.0.1:8080

Dans le fichier Lecoincoin/grails-app/conf/application.yml, il faut modifier la valeur path de datalecoincoin (dernières lignes du fichier) pour qu'elle corresponde à l'arborescence locale du projet.

Il existe 3 comptes "de debug", le compte Administrateur:
 - login: admin
 - password: admin
 le compte Modérateur :
 - login: modo
 - password: modo
 le compte Utilisateur :
 - login: slave
 - password: slave

L'application génère les compte de M. et Mme. Lecoincoin. M. Lecoincoin peut se connecter en temps qu'Administrateur avec :
 - login: LeCoinCoin
 - password: lecoincoin
M. Lecoincoin possède également un article rédigé par défaut.

Mme. Lecoincoin peut se connecter en temps que Modérateur avec :
 - login: LaCoinCoin
 - password: lacoincoin
Mm. Lecoincoin possède également un article par défaut.

L'application génère également 200 comptes "aléatoires" avec comme mot de passe "password", et dont les droits d'accès sont Utilisateurs.

L'administrateur peut créer, modifier et supprimer les annonces, et par extension, les illustrations. Il peut également visualiser l'intégralité des annonces et des utilisateurs enregristrés dans la base de donnée.

Le modérateur peut visualiser l'intégralité des annonces et des utilistaeurs de la base de données, mais ne peut modifier ou supprimer que ses propres annonces et illustrations, ou modifier uniquement son propre profil.

L'utilisateur ne peut voir, modifier et supprimer que ses propres annonces et son propre profil.


L'application fournit également une interface api à l'adresse 127.0.0.1:8080/api
On peut y retrouver les annonces ou les utilisateurs, au format json ou xml.

L'application fournit également une interface api à l'adresse 127.0.0.1:8080/api
On peut y retrouver les annonces ou les utilisateurs, au format json ou xml.
