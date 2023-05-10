#!/bin/bash

nombre=$#

if [ "$nombre" -eq 0 ]; then
  mois=$(date +%m)
  jour=$(date +%d)
  nombre=$((mois + jour))
fi

for i in $(seq 1 "$nombre"); do
  echo "Il me faut un $i"
done
