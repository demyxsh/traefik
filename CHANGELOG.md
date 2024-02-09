# CHANGELOG

## 2024-02-08
- Update description with shameless plug and support link [4af0ee3](https://github.com/demyxsh/traefik/commit/4af0ee3370afec7caaf3394be271b24d3387ba84)
- Set base image to Alpine 3.18 [567068b](https://github.com/demyxsh/traefik/commit/567068bfc278d1353c81e0096875492a077368d8)

## 2022-05-18
- Remove keys for http entrypoint [7d04362](https://github.com/demyxsh/traefik/commit/7d04362bb96cf19115b155d195908ecb5608e194)
- Remove whitespace [3f9cf5f](https://github.com/demyxsh/traefik/commit/3f9cf5f89c784a80e9d4586a8efa3f31f1eea1a3)
- Use new lines instead with prespaced dashes [d7a457f](https://github.com/demyxsh/traefik/commit/d7a457f2bf462f33e9ad5474b1adf02c19d26485)

## 2021-08-16
- Last comma is removed for some reason, echo one out [554a19d](https://github.com/demyxsh/traefik/commit/554a19d370fb6e12b81a10cf77e25455bd6434e3)

## 2021-04-03
- Added
    - `Dockerfile`
        - go mod tidy
- Changed
- Removed

## 2021-03-08
- Added
- Changed
    - Renamed src to config.
    - `Dockerfile`
        - Update COPY directory.
        - Rearrange RUN commands.
        - Add bash to packages.
        - Update bash PS1.
        - Update COPY directory.
        - Move some commands to finalize RUN.
- Removed

## 2020-07-13
### Changed
- The entrypoint is now a Golang binary
- DEMYX_ACME_EMAIL must be set or the container will exit

## 2020-05-31
### Changed
- Enable dashboard

## 2020-05-16
### Changed
- Add null as default value for temporary environment variable or else container will fail

## 2020-05-13
### Changed
- Renamed environment variables
- Use a YAML file to configure Traefik

## 2020-04-14
### Changed
- Set dumb-init as the shebang in the entrypoint
- Format LABEL and ENV entries
- Divide RUN commands to configure demyx and package installs
- Update finalize RUN commands
