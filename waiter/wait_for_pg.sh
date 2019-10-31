#!/bin/bash
set -e

>&2 printf "Waiting until database service is ready"

until psql -h "$1" -U postgres -q -c '\l' > /dev/null 2>&1; do
  >&2 printf "."
  sleep 1
done

printf "\nDatabase service is ready!\n"
