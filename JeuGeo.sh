#!/bin/bash

is_valid_codepostal() {
  local codepostal=$1
  if echo "$codepostal" | grep -Eq '^[0-9]{5}$'; then
    return 0
  else
    return 1
  fi
}

get_communes_info() {
  cache_dir="cache"

  if [ ! -d "$cache_dir" ]; then
    mkdir "$cache_dir"
  fi

  local codepostal=$1
  local refreshcache=$2

  local cache_file="$cache_dir/cache_$codepostal.txt"

  if [ -f "$cache_file" ] && [ -z "$refreshcache" ]; then
    local cache_timestamp=$(stat -c %Y "$cache_file")
    local current_timestamp=$(date +%s)
    local cache_age=$((current_timestamp - cache_timestamp))

    if [ "$cache_age" -lt 3600 ]; then
      cat "$cache_file"
      return
    fi
  fi

  local api_url="https://geo.api.gouv.fr/communes?codePostal=$codepostal&fields=nom,code,codesPostaux,siren,codeEpci,codeDepartement,codeRegion,population&format=json&geometry=centre"
  local response=$(curl -s "$api_url")

  if [ $? -eq 0 ] && [ ! -z "$response" ]; then
    echo "$response" > "$cache_file"
    echo "$response"
  else
    echo "Erreur lors de la récupération des données des communes."
    exit 1
  fi
}

display_communes_menu() {
  echo "Avec quelle ville souhaitez-vous jouer ?"

  IFS=$','
  local i=0
  for commune in $communes; do
    echo "[ $i ] $commune"
    i=$((i + 1))
  done
  unset IFS
}

if [ $# -eq 1 ]; then
  codepostal=$1

  if ! is_valid_codepostal "$codepostal"; then
    echo "Code postal invalide."
    exit 1
  fi
else
  while true; do
    read -p "Veuillez saisir un code postal : " codepostal
    if is_valid_codepostal "$codepostal"; then
      break
    else
      echo "Code postal invalide."
    fi
  done
fi

if [ $# -eq 2 ] && [ "$2" == "--refreshcache" ]; then
  refreshcache="--refreshcache"
else
  refreshcache=""
fi

communes_info=$(get_communes_info "$codepostal" "$refreshcache")
communes=$(echo "$communes_info" | jq -r '.[].nom' | paste -sd ",")

if [ -z "$communes" ]; then
  echo "Aucune commune trouvée pour le code postal $codepostal."
  exit 1
fi

display_communes_menu $communes

while true; do
  read -p "Choisissez un numéro de commune : " choix
  num_communes=$(echo "$communes" | awk -F',' '{print NF}')
  if [ "$choix" -ge 0 ] && [ "$choix" -lt "$num_communes" ]; then
    break
  else
    echo "Numéro de commune invalide."
  fi
done

vies=10

commune_selected=$(echo "$communes_info" | jq -r ".[$choix].population")

if [ -z "$commune_selected" ]; then
echo "Erreur lors de la sélection de la commune."
  exit 1
fi

habitants=$(echo "$commune_selected")

check_reponse() {
  local reponse=$1

  if [ "$reponse" -eq "$habitants" ]; then
    echo "Bravo ! Vous avez trouvé le bon nombre d'habitants ($habitants)."
    exit 0
  elif [ "$reponse" -gt "$habitants" ]; then
    echo "Plus petit."
  else
    echo "Plus grand."
  fi
}

while [ "$vies" -gt 0 ]; do
  echo "Nombre de vies restantes : $vies"
  read -p "Combien d'habitants dans la commune ? " reponse

if echo "$reponse" | grep -Eq '^[0-9]+$'; then
    check_reponse "$reponse"
    vies=$((vies - 1))
  else
    echo "Veuillez saisir un nombre entier."
  fi
done

echo "Vous avez épuisé toutes vos vies. Le nombre d'habitants était $habitants."
