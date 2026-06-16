#!/bin/sh
set -e

mkdir -p ~/.local/share/opencode

printf '{\n  "deepseek": {\n    "type": "api",\n    "key": "%s"\n  }' "$DEEPSEEK_API_KEY" > ~/.local/share/opencode/auth.json
if [ -n "$MOONSHOT_API_KEY" ]; then
  printf ',\n  "moonshotai": {\n    "type": "api",\n    "key": "%s"\n  }' "$MOONSHOT_API_KEY" >> ~/.local/share/opencode/auth.json
fi
printf '\n}\n' >> ~/.local/share/opencode/auth.json

gh auth setup-git

GH_USER=$(gh api user --jq '.login' 2>/dev/null || echo "unknown")
if [ "$GH_USER" != "unknown" ]; then
  git config --global user.name "$GH_USER"
  git config --global user.email "${GH_USER}@users.noreply.github.com"
fi

cat ~/.config/opencode/AGENTS.md - <<EOF > ~/.config/opencode/AGENTS.md.tmp

## GitHub Identity
- Authenticated to GitHub as: @${GH_USER}
- Git remote convention: \`origin\` points to the repo being worked on
- Use \`gh\` CLI for all GitHub operations
EOF
mv ~/.config/opencode/AGENTS.md.tmp ~/.config/opencode/AGENTS.md

exec opencode web --hostname 0.0.0.0 --port 3000
