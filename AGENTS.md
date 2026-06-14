# my-opencode-setup — Global OpenCode Rules
This file is injected into `~/.config/opencode/AGENTS.md` by the Dockerfile and applies to all opencode sessions running inside this container.

## Docker & Environment
- This is a containerized, web-hosted opencode environment. The web UI runs on port 3000.
- No systemd.
- The home directory is `/home/ubuntu` (override via `--build-arg USER_HOME=<path>`).
- Tools like `gh`, `git`, `docker`, `node`, `python`, and standard Unix utilities are available.
- Global npm/pip/cargo packages belong under `/home/ubuntu` (or `${USER_HOME}`).
- Auth is configured via `DEEPSEEK_API_KEY` environment variable at container startup.

## General Guidelines
- Use concise, direct communication. Avoid unnecessary preamble or postamble.
- Follow security best practices. Never expose or log secrets and keys.
- Prefer editing existing files over creating new ones.
- Use the project's existing conventions, libraries, and patterns.

## Tool Usage
- Use dedicated file operation tools (Read, Write, Edit, Glob, Grep) instead of bash commands for file operations.
- Run independent operations in parallel when possible.
- Verify changes with tests when available.

## Docker-in-Docker
- Docker CLI is available inside the container, backed by a separate `docker:27-dind` sidecar container running `dockerd` on TCP port 2375.
- Configured via `docker-compose.yml`. The dind service uses named volumes (`dind-data`, `buildkit-cache`) and the opencode container sets `DOCKER_HOST=tcp://dind:2375`.

## GitHub
- Use `gh` CLI for GitHub operations. Auth is handled via `GH_TOKEN` environment variable.
- Default git remote convention: `origin` points to the repo being worked on.
