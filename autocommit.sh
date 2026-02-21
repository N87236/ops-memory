#!/usr/bin/env bash
set -euo pipefail

REPO="/home/nate/.openclaw/workspace/ops-memory"
cd "$REPO"

# Ensure today's file exists (UTC)
TODAY="memory/$(date -u +%F).md"
if [ ! -f "$TODAY" ]; then
  cat > "$TODAY" <<EOT
# $(date -u +%F) (UTC)
## Summary
## Decisions
## Tasks / Next actions
## Links / Paths
EOT
fi

# Stage changes
git add -A

# If nothing changed, exit quietly
if git diff --cached --quiet; then
  exit 0
fi

# Commit with UTC timestamp
git commit -m "daily memory $(date -u +%F) $(date -u +%H:%M)Z"

# Push (assumes origin already set and SSH works)
git push
