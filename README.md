# my-opencode-setup

Dockerized OpenCode server environment.

## Deploy with Dokploy

1. Add this repo as a Compose source in Dokploy (Git provider)
2. Set the following environment variables in Dokploy:

| Variable | Description |
|----------|-------------|
| `DOMAIN` | Subdomain for this service (e.g. `opencode.dokploy.boronine.com`) |
| `DEEPSEEK_API_KEY` | DeepSeek API key |
| `GH_TOKEN` | GitHub personal access token |
| `OPENCODE_SERVER_PASSWORD` | Password for the OpenCode web UI |
| `MOONSHOT_API_KEY` | (optional) Moonshot API key |

3. Deploy — Traefik auto-provisions SSL via Let's Encrypt
4. Access at `https://$DOMAIN`
