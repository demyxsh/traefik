#!/usr/bin/dumb-init /bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Generate config if it doesn't exist
[[ ! -f "$DEMYX_CONFIG"/traefik.yml ]] && demyx-config

# Start the edge router
traefik --configfile="$DEMYX_CONFIG"/traefik.yml
