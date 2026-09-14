# my-opencode-setup

Dockerized OpenCode server environment.

## Configuration

Set the following environment variables:

| Variable | Description |
|----------|-------------|
| `DOMAIN` | Domain for this service (e.g. `opencode.example.com`) |
| `DEEPSEEK_API_KEY` | DeepSeek API key |
| `GH_TOKEN` | (optional) GitHub personal access token |
| `GITEA_TOKEN` | (optional) Gitea access token |
| `GITEA_SERVER_URL` | (optional) Gitea server URL (defaults to `https://gitea.com`) |
| `OPENCODE_SERVER_PASSWORD` | Password for the OpenCode web UI |
| `MOONSHOT_API_KEY` | (optional) Moonshot API key |

Run with Docker Compose — Traefik auto-provisions SSL via Let's Encrypt at `https://$DOMAIN`.
