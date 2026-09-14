#!/bin/sh
set -e

mkdir -p ~/.local/share/opencode

printf '{\n  "deepseek": {\n    "type": "api",\n    "key": "%s"\n  }' "$DEEPSEEK_API_KEY" > ~/.local/share/opencode/auth.json
if [ -n "$MOONSHOT_API_KEY" ]; then
  printf ',\n  "moonshotai": {\n    "type": "api",\n    "key": "%s"\n  }' "$MOONSHOT_API_KEY" >> ~/.local/share/opencode/auth.json
fi
printf '\n}\n' >> ~/.local/share/opencode/auth.json

GITEA_URL="${GITEA_SERVER_URL:-https://gitea.com}"

GH_USER=""
GITEA_USER=""
GITEA_EMAIL=""

if [ -n "$GH_TOKEN" ]; then
  gh auth setup-git
  GH_USER=$(gh api user --jq '.login' 2>/dev/null || echo "")
fi

if [ -n "$GITEA_TOKEN" ]; then
  tea login delete gitea >/dev/null 2>&1 || true
  tea login add --name gitea --url "$GITEA_URL" --token "$GITEA_TOKEN" --git-credentials --no-version-check >/dev/null 2>&1 || true
  GITEA_PROFILE=$(tea api --login gitea /user 2>/dev/null || echo "")
  GITEA_USER=$(printf '%s' "$GITEA_PROFILE" | sed -n 's/.*"login":"\([^"]*\)".*/\1/p')
  GITEA_EMAIL=$(printf '%s' "$GITEA_PROFILE" | sed -n 's/.*"email":"\([^"]*\)".*/\1/p')
fi

if [ -n "$GH_USER" ]; then
  git config --global user.name "$GH_USER"
  git config --global user.email "${GH_USER}@users.noreply.github.com"
elif [ -n "$GITEA_USER" ]; then
  git config --global user.name "$GITEA_USER"
  if [ -n "$GITEA_EMAIL" ]; then
    git config --global user.email "$GITEA_EMAIL"
  else
    GITEA_HOST=$(printf '%s' "$GITEA_URL" | sed -n 's|^[a-zA-Z][a-zA-Z0-9+.-]*://\([^/]*\).*|\1|p')
    git config --global user.email "${GITEA_USER}@noreply.${GITEA_HOST}"
  fi
fi

{
  cat ~/.config/opencode/AGENTS.md
  if [ -n "$GH_USER" ]; then
    printf '\n## GitHub Identity\n- Authenticated to GitHub as: @%s\n- Git remote convention: `origin` points to the repo being worked on\n- Use `gh` CLI for all GitHub operations\n' "$GH_USER"
  fi
  if [ -n "$GITEA_USER" ]; then
    printf '\n## Gitea Identity\n- Authenticated to Gitea (%s) as: @%s\n- Git remote convention: `origin` points to the repo being worked on\n- Use `tea` CLI for all Gitea operations\n' "$GITEA_URL" "$GITEA_USER"
  fi
} > ~/.config/opencode/AGENTS.md.tmp

mv ~/.config/opencode/AGENTS.md.tmp ~/.config/opencode/AGENTS.md

exec opencode web --hostname 0.0.0.0 --port 3000
