FROM ubuntu

RUN apt update && apt install -y wget curl xdg-utils docker.io \
	&& mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& apt update \
	&& apt install gh -y \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME=/home/ubuntu \
	PATH="/home/ubuntu/.opencode/bin:$PATH" \
	BROWSER=true \
	OPENCODE_ENABLE_EXA=1

RUN curl -fsSL https://opencode.ai/install | bash \
	&& mkdir -p /home/ubuntu/.config/opencode \
	&& chown -R ubuntu:ubuntu /home/ubuntu

COPY init.sh /home/ubuntu/init.sh
RUN chmod +x /home/ubuntu/init.sh

USER ubuntu

COPY GLOBAL_AGENTS.md /home/ubuntu/.config/opencode/AGENTS.md

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
	CMD curl -sS http://localhost:3000/ > /dev/null || exit 1

CMD ["/home/ubuntu/init.sh"]
