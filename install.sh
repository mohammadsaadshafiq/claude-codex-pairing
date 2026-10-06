#!/usr/bin/env bash
# One-step install: puts `duo` on your PATH for new terminals, then runs a self-check.
set -euo pipefail
DEST="${PREFIX:-$HOME/.local}/bin"
mkdir -p "$DEST"
cp "$(cd "$(dirname "$0")" && pwd)/bin/duo" "$DEST/duo"
chmod +x "$DEST/duo"
echo "✔ installed $DEST/duo"

case ":$PATH:" in
  *":$DEST:"*) echo "✔ $DEST is already on your PATH" ;;
  *)
    case "${SHELL:-}" in */zsh) RC="$HOME/.zshrc" ;; */bash) RC="$HOME/.bashrc" ;; *) RC="" ;; esac
    LINE="export PATH=\"$DEST:\$PATH\""
    if [ -n "$RC" ]; then
      grep -qsF "$LINE" "$RC" || printf '\n# added by claude-codex-pairing\n%s\n' "$LINE" >> "$RC"
      echo "✔ added $DEST to PATH in $RC (open a new terminal, or run: source $RC)"
    else
      echo "? unknown shell: add this to your shell profile:  $LINE"
    fi ;;
esac
echo
"$DEST/duo" --doctor || true
echo
echo 'Try it inside any project folder:  duo "your question"'
