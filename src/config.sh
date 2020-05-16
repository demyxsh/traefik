#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Temporary support for the demyx stack
[[ -n "${TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_EMAIL:-}" ]] && DEMYX_ACME_EMAIL="$TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_EMAIL"

echo "entryPoints:
  http:
    address: :8081
    forwardedHeaders:
      trustedIPs:
      - ${DEMYX_TRUSTED_IPS}
  https:
    address: :8082
    forwardedHeaders:
      trustedIPs:
      - ${DEMYX_TRUSTED_IPS}

certificatesResolvers:
  demyx:
    acme:
      email: ${DEMYX_ACME_EMAIL:-}
      storage: ${DEMYX}/acme.json
      httpChallenge:
        entryPoint: http
  demyx-cf:
    acme:
      email: ${DEMYX_ACME_EMAIL:-}
      storage: ${DEMYX}/acme.json
      dnsChallenge:
        provider: cloudflare
        delayBeforeCheck: 0
        resolvers:
          - 1.1.1.1

providers:
  docker:
    endpoint: $DEMYX_ENDPOINT
    exposedByDefault: false

api:
  dashboard: false

log:
  level: INFO
  filePath: ${DEMYX_LOG}/traefik.error.log

accessLog:
  filePath: ${DEMYX_LOG}/traefik.access.log
" > "$DEMYX_CONFIG"/traefik.yml
