# traefik
[![Build Status](https://img.shields.io/travis/demyxco/traefik?style=flat)](https://travis-ci.org/demyxco/traefik)
[![Docker Pulls](https://img.shields.io/docker/pulls/demyx/traefik?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Alpine](https://img.shields.io/badge/alpine-3.11.7-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Traefik](https://img.shields.io/badge/traefik-2.3.7-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)
[![Become a Patron!](https://img.shields.io/badge/become%20a%20patron-$5-informational?style=flat&color=blue)](https://www.patreon.com/bePatron?u=23406156)

Non-root Docker image running Alpine Linux and Traefik. Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need.

DEMYX | TRAEFIK
--- | ---
USER | demyx
ENTRYPOINT | ["demyx-entrypoint"]
PORT | 8080 8081 8082

## Usage
- Since a non-root user can't access docker.sock, this image depends on my lockdown docker.sock proxy [container](https://github.com/demyxco/docker-socket-proxy).
- DEMYX_ACME_EMAIL must be set or the container will exit.

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
-e DEMYX=/demyx \
-e DEMYX_CONFIG=/etc/demyx \
-e DEMYX_LOG=/var/log/demyx \
-e DEMYX_ENDPOINT=tcp://demyx_socket:2375 \
-e DEMYX_ACME_EMAIL=info@domain.tld \ # Required
-p 80:8081 \
-p 443:8082 \
-v traefik:/demyx \     # Point your acme.json storage to this directory (ex: /demyx/acme.json)
demyx/traefik
```

For more configurations, see Traefik's official documentations: https://docs.traefik.io.

## Updates & Support
[![Code Size](https://img.shields.io/github/languages/code-size/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Repository Size](https://img.shields.io/github/repo-size/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Watches](https://img.shields.io/github/watchers/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Stars](https://img.shields.io/github/stars/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)
[![Forks](https://img.shields.io/github/forks/demyxco/traefik?style=flat&color=blue)](https://github.com/demyxco/traefik)

* Auto built weekly on Saturdays (America/Los_Angeles)
* Rolling release updates
* For support: [#demyx](https://webchat.freenode.net/?channel=#demyx)
