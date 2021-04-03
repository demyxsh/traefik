# CHANGELOG

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
