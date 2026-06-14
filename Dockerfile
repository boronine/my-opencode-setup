FROM ubuntu:latest

ARG USER_HOME=/root

RUN mkdir -p ${USER_HOME}/.config/opencode

COPY AGENTS.md ${USER_HOME}/.config/opencode/AGENTS.md

RUN chmod 644 ${USER_HOME}/.config/opencode/AGENTS.md
