# CHANGELOG

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
