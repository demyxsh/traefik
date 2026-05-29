# Changelog

## 2026-05-29
### Added
- None.
### Changed
- Bump `DEMYX_VERSION` to `1.11.0` in GitHub Actions Docker workflow.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2026-05-27
### Added
- None.
### Changed
- Move `DEMYX_VERSION` to job-level `env` key set to `1.10.0` instead of resolving dynamically from remote `demyx` orchestrator via a workflow step.
- Add `v1` moving tag to build and push steps in GitHub Actions workflow.
- Changed scheduled GitHub Actions build day from Saturday to Thursday.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2026-05-25
### Added
- None.
### Changed
- Updated GitHub Actions Docker workflow to publish existing moving image tag(s) plus versioned tag(s) derived from `DEMYX_VERSION` from the `demyx` orchestrator.
### Fixed
- None.
### Removed
- None.
### Security
- None.


## 2026-05-09
### Added
- None.
### Changed
- Updated builder image from `golang:alpine3.18` to `golang:alpine3.22`.
- Pinned runtime image from `traefik` to `traefik:v3`.
- Scheduled build run.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2026-05-08
### Added
- None.
### Changed
- Updated builder image to `golang:alpine3.22` and pinned runtime image to `traefik:v3`.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2025-07-28
### Added
- None.
### Changed
- Directed users to Demyx.
- Switched to main ports.
- Updated exposed ports.
- Updated GitHub Actions workflow commit message format to include run ID.
### Fixed
- Fixed deprecated warnings.
### Removed
- None.
### Security
- None.

## 2024-11-06
### Added
- None.
### Changed
- Updated deprecated warning handling.
### Fixed
- Fixed deprecated warnings.
### Removed
- None.
### Security
- None.

## 2024-05-07
### Added
- None.
### Changed
- Reverted ports back to `8081` and `8082`.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2024-05-06
### Added
- None.
### Changed
- Enabled HTTP/3.
- Updated SSL-related configuration for improved rating.
- Misc updates.
### Fixed
- Fixed GitHub Actions error.
### Removed
- None.
### Security
- None.

## 2024-02-08
### Added
- None.
### Changed
- Updated description with support and project links.
- Set base image to Alpine 3.18.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2022-05-18
### Added
- None.
### Changed
- Used new lines with prespaced dashes.
### Fixed
- Removed whitespace issues.
### Removed
- Removed keys for HTTP entrypoint.
### Security
- None.

## 2021-08-16
### Added
- None.
### Changed
- Added fallback echo for missing trailing comma behavior.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2021-04-03
### Added
- Added `go mod tidy` step in `Dockerfile`.
### Changed
- None.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2021-03-08
### Added
- None.
### Changed
- Renamed `src` to `config`.
- Updated Dockerfile `COPY` directory.
- Rearranged `RUN` commands.
- Added bash to packages.
- Updated bash `PS1`.
- Moved some commands to final `RUN`.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2020-07-13
### Added
- None.
### Changed
- Entry point is now a Golang binary.
- `DEMYX_ACME_EMAIL` is now required or container exits.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2020-05-31
### Added
- None.
### Changed
- Enabled dashboard.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2020-05-16
### Added
- None.
### Changed
- Added `null` default for temporary environment variable to prevent container failure.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2020-05-13
### Added
- None.
### Changed
- Renamed environment variables.
- Switched Traefik configuration to YAML file.
### Fixed
- None.
### Removed
- None.
### Security
- None.

## 2020-04-14
### Added
- None.
### Changed
- Set `dumb-init` as the shebang in the entrypoint.
- Formatted `LABEL` and `ENV` entries.
- Split `RUN` commands for Demyx configuration and package installs.
- Updated final `RUN` commands.
### Fixed
- None.
### Removed
- None.
### Security
- None.
