#!/bin/bash

read -p "Entrez le chemin que vous souhaitez lister : " chemin

if [ ! -d "$chemin" ]; then
  echo "Le chemin spécifié n'existe pas ou n'est pas un répertoire."
  exit 1
fi

ls -alR --group-directories-first --color=auto "$chemin"
