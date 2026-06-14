# Agent Instructions

This repository defines a containerized [OpenCode](https://opencode.ai/) environment.

## `GLOBAL_AGENTS.md`

`GLOBAL_AGENTS.md` contains the global OpenCode rules. During the Docker build, it is copied to `/home/ubuntu/.config/opencode/AGENTS.md` inside the container so that every OpenCode session starts with the same baseline instructions.

At runtime, `init.sh` appends container-specific information (such as the authenticated GitHub user) to that injected file.

## Project-specific rules

Individual projects can still include their own `AGENTS.md` files. When OpenCode opens a project, it reads any `AGENTS.md` found in the project directory in addition to the global rules.
