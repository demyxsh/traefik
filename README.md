# traefik
[![Build Status](https://img.shields.io/travis/demyxco/traefik?style=flat)](https://travis-ci.org/demyxco/traefik)
[![Docker Pulls](https://img.shields.io/docker/pulls/demyx/traefik?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Alpine](https://img.shields.io/badge/alpine-3.10.2-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Traefik](https://img.shields.io/badge/traefik-2.0.5-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)

Non-root Docker image running Alpine Linux and Traefik. This image has been stripped of all binaries except Traefik to further lock down the container. 

DEMYX | TRAEFIK
--- | ---
USER | demyx
ENTRYPOINT | ["/traefik"]
PORT | 8080 8081 8082

## Updates & Support
[![Code Size](https://img.shields.io/github/languages/code-size/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Repository Size](https://img.shields.io/github/repo-size/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Watches](https://img.shields.io/github/watchers/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Stars](https://img.shields.io/github/stars/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Forks](https://img.shields.io/github/forks/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)

* Auto built weekly on Sundays (America/Los_Angeles)
* Rolling release updates
* For support: [#demyx](https://webchat.freenode.net/?channel=#demyx)

## Environment Variables
These are the default environment variables.

```
- TRAEFIK_ENTRYPOINTS_HTTP_ADDRESS=:8081    # http is the insecure entrypoint name
- TRAEFIK_ENTRYPOINTS_HTTPS_ADDRESS=:8082   # https is the insecure entrypoint name
- TZ=America/Los_Angeles
```

## Usage
Since a non-root user can't access docker.sock, this image depends on my lockdown docker.sock proxy [container](https://github.com/demyxco/docker-socket-proxy).

```
# Start the docker.sock proxy container first
docker run -d \
--privileged \
--name=demyx_socket \
--network=demyx_socket \
-v /var/run/docker.sock:/var/run/docker.sock \
-e CONTAINERS=1 \
demyx/docker-socket-proxy

# Start Traefik container
docker run -d \
--name=traefik \
--network=demyx_socket \
-e TRAEFIK_PROVIDERS_DOCKER_ENDPOINT=tcp://demyx_socket:2375 \
-p 80:8081 \
-p 443:8082 \
demyx/traefik
```

For more configurations, see Traefik's official documentations: https://docs.traefik.io.
