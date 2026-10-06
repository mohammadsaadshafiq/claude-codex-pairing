#!/usr/bin/env bash
# Installs `duo` into ~/.local/bin (or $PREFIX/bin).
set -euo pipefail
DEST="${PREFIX:-$HOME/.local}/bin"
mkdir -p "$DEST"
cp "$(dirname "$0")/bin/duo" "$DEST/duo"
chmod +x "$DEST/duo"
echo "Installed to $DEST/duo"
case ":$PATH:" in *":$DEST:"*) ;; *) echo "Add $DEST to your PATH." ;; esac
for t in claude codex perl; do command -v "$t" >/dev/null || echo "Missing dependency: $t"; done
