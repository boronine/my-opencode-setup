FROM ubuntu
# GitHub CLI
RUN apt update && apt install -y wget curl xdg-utils
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
ENV PATH="/home/ubuntu/.opencode/bin:$PATH"
ENV BROWSER=true
ENV OPENCODE_ENABLE_EXA=1
USER ubuntu
EXPOSE 3000
CMD ["sh", "-c", "mkdir -p ~/.local/share/opencode && printf '{\n  \"deepseek\": {\n    \"type\": \"api\",\n    \"key\": \"%s\"\n  }\n}\n' \"$DEEPSEEK_API_KEY\" > ~/.local/share/opencode/auth.json && gh auth setup-git && opencode web --hostname 0.0.0.0 --port 3000"]
