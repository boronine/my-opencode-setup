FROM ubuntu
# GitHub CLI
RUN apt update && apt install -y wget curl xdg-utils docker.io
RUN mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& apt update \
	&& apt install gh -y
ENV HOME=/home/ubuntu
RUN curl -fsSL https://opencode.ai/install | bash \
	&& chown -R ubuntu:ubuntu /home/ubuntu
RUN mkdir -p /home/ubuntu/.config/opencode
COPY AGENTS.md /home/ubuntu/.config/opencode/AGENTS.md
COPY init.sh /home/ubuntu/init.sh
RUN chown ubuntu:ubuntu /home/ubuntu/.config/opencode/AGENTS.md /home/ubuntu/init.sh \
    && chmod +x /home/ubuntu/init.sh
ENV PATH="/home/ubuntu/.opencode/bin:$PATH"
ENV BROWSER=true
ENV OPENCODE_ENABLE_EXA=1
USER ubuntu
EXPOSE 3000
CMD ["/home/ubuntu/init.sh"]
