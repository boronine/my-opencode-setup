# Agent Rules

You run inside a containerized Ubuntu environment as the `ubuntu` user.

## Environment
- Home directory: `/home/ubuntu`.
- `systemd` is not available; do not use `systemctl` or services.
- `sudo` is available without a password.

## Tools & Conventions
- Use `gh` for all GitHub operations.
- Use `git` for version control; the default remote convention is `origin`.
- `docker`, `node`, `python`, and standard Unix utilities are available.
- Install global npm/pip/cargo packages under `/home/ubuntu` (or `${HOME}`).

## Docker-in-Docker
- The `docker` CLI talks to a separate DinD daemon via `DOCKER_HOST=tcp://dind:2375`.
- Do not try to start or manage a local Docker daemon.
