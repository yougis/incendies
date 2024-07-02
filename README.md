-----------------------------------------------------------
# L'application de photo-interprétation
-----------------------------------------------------------

Le script "app_stl2_fire_detection_V2.ipynb" génère l'application de photo-interprétation à partir des données de polygones issues directement en base de donnée et de la récupération d'images Sentinel-2 grâce à l'API de Google Earth Engine.

Un filtrage des données est réalisé grâce à un choix d'intervalle de date via deux widget "date_start" et "date_end"  

Plusieurs modes sont disponibles dans cette application de nouveaux modes peuvent être ajoutés en suivant la logique fournie dans le script.
## Modes

5 modes ont été ajoutés à l'application afin de répondres à nos demandes :

**Mode par groupe :**  

    Possibilité de filtrer les données selon 2 types:   
        - Les zones à enjeux (ZAE)
        - Le reste (Autre)
**Mode CQ :**  

    Deux types de Contrôle Qualité peuvent être effectués :
        - CQ Brute : sur les données en sortie de chaine INSIGHT donc Brute, cette approche permet de donner une information sur la qualité de l'algorithme de détection  
        - CQ PI : sur des données déjà photo-interprétés et validés, on fait une 2e photo-interprétation sur les polygones validés afin de valider la PI  
**Mode FLAG:**  

    Ce mode est utile pour filtrer les polygones qui ont été photo-interprés mais difficilement photo-interprétable, on essaye ici de les réévaluer  
**Mode PI Entrainement:**  

    Ce mode doit être utilisé par tout nouveau photo-interprète pour se former à la PI, un groupe de 1000 formes a été préalablement échantillonné et stocké dans un fichier csv pour sa réutilisation (voir fichier "list_traning_pi.csv")   

Pour les modes : **CQ et PI Entrainement**, la création d'une table temporaire (nommée : liste_surfaces_pi_temp) pour stocker les listes de polygones à photo-interpréter est réalisée.   
il existe deux options :  

    - Nouveau  
    - Existant  

Pour tout **nouveau** contôle qualité ou entrainement, les informations de l'échantillon seront stockées dans la table temporaire en gardant les informations du nom d'utilisateur et de son mode.   
Dans le cas d'une **reprise** d'un contrôle ou d'un entrainement, il sera possible de retrouver les polygones restants à photo-interpréter grâce à un filtrage de la table temporaire avec les informations du nom d'utilisateur et du mode   

## L'organisation des formes

Les formes sont organisées par HER (Hydro-écorégions) afin de faciliter la photo-interprétation, cela permet de rassembler les formes selon des régions similaires (exemple le HER E contient de nombreuses zones latéritiques, on sait qu'il y aura probablement beaucoup de polygones sur des cuirasses)  
Une liste déroulante des 7 HER de Nouvelle-Calédonie + "Hors_HER" permettront de filtrer l'affichage des polygones.  

## L'organisation des maps

3 maps sont mises à dispositions:  

    - une map avec l'image sentinel-2 en true color à la date de détection   
    - une map avec l'image sentinel-2 en false color infra-red à la date de détection 
    - une map contenant une collection d'image déterminer selon un intervalle de jours modifiable par l'utilisateur  
 
Pour accéder aux sources de données Sentinel-2 sur GEE, on utilise un fichier contenant les logins/mdp pour accéder au compte GEE, les informations sont contenues dans le fichier "gee_credantials.json"  
## Déployement 

Le script est déployé sur le serveur Mordor grâce à Docker à l'addresse suivante : http://172.20.12.13:8086/ , il utilise la technologie "Voilà" pour le déployement et il est nécessaire d'être connecté au Wifi de l'OEIL ou via le VPN fortiClient pour y accéder.  
L'environnement conda utile est contenu dans le fichier "environnement.yaml"

Le script peut aussi être lancé via la commande suivante pour des phases de tests :    

    voila app_stl2_fire_detection_V2.ipynb --no-browser --port=8080
-----------------------------------------------------------
# L'application de visualisation d'images Sentinel-2 
-----------------------------------------------------------

Cette application est utilisée dans pour vérifier les images Sentinel-2 d'une forme et obtenir une collection d'imges avant/après la date de détection. Il est nécessaire de renseigner la valeur de l'attribut "surface_id_h3" de la forme. Il s'affichera 4 maps :

    - une map avec l'image sentinel-2 en true color à la date de détection
    - une map avec l'image sentinel-2 en false color infra-red à la date de détection
    - une map avec l'image sentinel-2 avec les classes de NDVI à la date de détection (pas de légende disponible se référer aux couleur logique d'une végétation - Vert)
    - une map contenant une collection d'image déterminer selon un intervalle de jours modifiable par l'utilisateur 

L'application déployée sur le serveur Mordor grâce à Docker à l'addresse suivante : http://172.20.12.13:8087/ , il utilise la technologie "Voilà" pour le déployement et il est nécessaire d'être connecté au Wifi de l'OEIL via VPN pour y accéder. 
