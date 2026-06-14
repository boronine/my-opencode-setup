#!/bin/sh
set -e

mkdir -p ~/.local/share/opencode

printf '{\n  "deepseek": {\n    "type": "api",\n    "key": "%s"\n  }\n}\n' \
  "$DEEPSEEK_API_KEY" > ~/.local/share/opencode/auth.json

gh auth setup-git

GH_USER=$(gh api user --jq '.login' 2>/dev/null || echo "unknown")
cat >> ~/.config/opencode/AGENTS.md <<EOF

## GitHub Identity
- Authenticated to GitHub as: @${GH_USER}
- Git remote convention: \`origin\` points to the repo being worked on
- Use \`gh\` CLI for all GitHub operations
EOF

exec opencode web --hostname 0.0.0.0 --port 3000
