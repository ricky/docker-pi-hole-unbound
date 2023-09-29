#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

if [ ! -f "./.env" ]; then
    echo "WARNING: Using default values."
    echo "Customize .env as appropriate and re-run this script."
    echo "* Initializing .env"
    cp ./dotenv.example ./.env
fi

set -o allexport
. ./.env
set +o allexport

if hash envsubst 2>/dev/null; then
    envsubst < ./docker-compose.yml.tmpl > ./docker-compose.yml
else
    eval "echo \"$(cat ./docker-compose.yml.tmpl)\" > ./docker-compose.yml"
fi

echo "* Initializing docker-compose.yml"
