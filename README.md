# traefik
[![demyxsh/traefik](https://github.com/demyxsh/traefik/actions/workflows/main.yml/badge.svg)](https://github.com/demyxsh/traefik/actions/workflows/main.yml)
[![Code Size](https://img.shields.io/github/languages/code-size/demyxsh/traefik?style=flat&color=blue)](https://github.com/demyxsh/traefik)
[![Repository Size](https://img.shields.io/github/repo-size/demyxsh/traefik?style=flat&color=blue)](https://github.com/demyxsh/traefik)
[![Watches](https://img.shields.io/github/watchers/demyxsh/traefik?style=flat&color=blue)](https://github.com/demyxsh/traefik)
[![Stars](https://img.shields.io/github/stars/demyxsh/traefik?style=flat&color=blue)](https://github.com/demyxsh/traefik)
[![Forks](https://img.shields.io/github/forks/demyxsh/traefik?style=flat&color=blue)](https://github.com/demyxsh/traefik)
[![Docker Pulls](https://img.shields.io/docker/pulls/demyx/traefik?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Alpine](https://img.shields.io/badge/dynamic/json?url=https://github.com/demyxsh/traefik/raw/master/version.json&label=alpine&query=$.alpine&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Traefik](https://img.shields.io/badge/dynamic/json?url=https://github.com/demyxsh/traefik/raw/master/version.json&label=traefik&query=$.traefik&color=blue)](https://hub.docker.com/r/demyx/traefik)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)
[![Become a Patron!](https://img.shields.io/badge/become%20a%20patron-$5-informational?style=flat&color=blue)](https://www.patreon.com/bePatron?u=23406156)

Non-root Docker image running Alpine Linux and Traefik. Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need.

To properly utilize this image, please use [Demyx](https://demyx.sh/readme).
- Repository - [demyxsh/demyx](https://github.com/demyxsh/demyx)
- Homepage - [demyx.sh](https://demyx.sh)

[![Demyx Discord](https://discordapp.com/api/guilds/1152828583446859818/widget.png?style=banner2)](https://demyx.sh/discord)

Join us on Discord for latest news, faster support, or just chill.

<a href="https://demyx.sh/sponsor-buymeacoffee" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

Support this project by buying coffee (please).

DEMYX | TRAEFIK
--- | ---
USER | demyx
ENTRYPOINT | ["demyx-entrypoint"]
PORT | 8080 8081 8082

## NOTICE
This repository has been moved to the organization [demyxsh](https://github.com/demyxsh); please update the remote URL.
```
git remote set-url origin git@github.com:demyxsh/traefik.git
```

## Usage
- Since a non-root user can't access docker.sock, this image depends on my lockdown docker.sock proxy [container](https://github.com/demyxsh/docker-socket-proxy).
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
- Auto built weekly on Saturdays (America/Los_Angeles)
- Rolling release updates
- For support: [Discord](https://demyx.sh/discord)
