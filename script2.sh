#!/bin/bash

prenom=${1:-"Oh grand maitre"}

read -p "Entrez le chemin : " chemin

if [ ! -d "$chemin" ]; then
  echo "Le chemin spécifié n'existe pas ou n'est pas un répertoire."
  exit 1
fi

read -p "Entrez le nom du répertoire : " nom_repertoire

path="${chemin}/${nom_repertoire}"

if [ ! -w "$chemin" ]; then
  echo "Vous n'avez pas les droits d'écriture sur le chemin spécifié."
  echo "Utilisation de sudo pour créer le répertoire..."

  if sudo mkdir -p "$path"; then
    echo "Le répertoire a été créé à l'emplacement : $path"
  else
    echo "Impossible de créer le répertoire à l'emplacement spécifié."
    exit 1
  fi
else
  if mkdir -p "$path"; then
    echo "Le répertoire a été créé à l'emplacement : $path"
  else
    echo "Impossible de créer le répertoire à l'emplacement spécifié."
    exit 1
  fi
fi

read -p "Êtes-vous content, $prenom ? (oui/non) : " reponse

if [ "$reponse" = "oui" ]; then
  echo "Je suis ravi que vous soyez satisfait, $prenom !"
else
  echo "Je m'excuse si quelque chose ne va pas, $prenom. Nous ferons mieux la prochaine fois !"
fi

