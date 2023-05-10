# Fondamentaux Linux

Linux est un système d'exploitation largement utilisé, réputé pour sa stabilité, sa flexibilité et sa puissance. Comprendre les fondamentaux de Linux est essentiel pour tout administrateur système, développeur ou passionné de l'informatique.

## Objectif du module

Ce module a pour objectif d'apprendre les commandes les plus utilisées , la gestion des rôles et la création de scripts shell.

## JeuGeo.sh

Le script "JeuGeo.sh" est un jeu interactif basé sur les codes postaux et les informations sur les communes françaises. Voici un résumé des fonctionnalités principales du script :

- Le script peut être exécuté avec ou sans argument. Si un argument est fourni, il est considéré comme un code postal.

- Si aucun argument n'est fourni ou si l'argument n'est pas un code postal valide (5 chiffres), l'utilisateur est invité à saisir un code postal valide.

- Le script se connecte à une API pour récupérer les informations sur les communes correspondantes au code postal.

- Un système de cache local est mis en place pour éviter de requêter l'API à chaque fois. Le cache a une durée de vie de 60 minutes. L'utilisateur peut utiliser l'argument "--refreshcache" en plus du code postal pour renouveler le cache sans tenir compte de l'horodatage.

- Un menu est affiché avec les noms des différentes communes associées au code postal. L'utilisateur est invité à choisir une commune en entrant un numéro correspondant.

- Un nombre de vies est défini (10 vies par défaut).

- L'utilisateur est invité à deviner le nombre d'habitants dans la commune choisie. Le script lui indique si sa réponse est supérieure ou inférieure et déduit une vie à chaque tentative.

- La saisie de l'utilisateur est vérifiée pour s'assurer qu'elle est un nombre entier.

Le script utilise l'API Geo de l'administration française pour récupérer les informations sur les communes.

## Auteur

Ce projet a été créé par **Romain AROLDI** dans le cadre du module Fondamentaux Linux dispensé par **Maxime ROLLAND**.