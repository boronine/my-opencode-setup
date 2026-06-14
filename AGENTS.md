# Global OpenCode Rules
These rules apply across all opencode sessions.

## General Guidelines
- Use concise, direct communication. Avoid unnecessary preamble or postamble.
- Follow security best practices. Never expose or log secrets and keys.
- After making changes, always run lint and typecheck commands if available.
- Prefer editing existing files over creating new ones.
- Use the project's existing conventions, libraries, and patterns.

## Code Style
- Mimic the surrounding code style when making changes.
- Do not add comments unless explicitly asked.
- Preserve existing indentation (tabs/spaces) exactly.

## Tool Usage
- Use dedicated file operation tools (Read, Write, Edit, Glob, Grep) instead of bash commands for file operations.
- Run independent operations in parallel when possible.
- Verify changes with tests when available.
