# ops-memory

Git-backed configuration + memory store for the OpenClaw assistant.

## Contents
- `HEARTBEAT.md` / `MEMORY.md`: canonical heartbeat + long-term memory templates (symlinked into the workspace root)
- `memory/`: daily logs (`YYYY-MM-DD.md`)
- `logs/`: heartbeat + bridge logs
- `scripts/`: automation scripts (e.g., parlay builder)
- `analysis/`: generated reports / briefings
- `data/`: raw data snapshots (lines/injuries/etc.)

## Parlay Builder (WIP)
The `scripts/parlay_builder.py` scaffold pulls sportsbook lines + injury data, applies heuristics, and writes a styled report under `analysis/DATE.md`.

### Environment
Create `.env` in repo root (never commit) based on `.env.example`:
```
HARDROCK_API_KEY=...
HARDROCK_API_BASE=https://api.hardrock.bet
INJURY_FEED_URL=https://...
```
Additional keys (Brave Search, custom feeds) can be added as needed.

### Manual run
```
cd /home/nate/.openclaw/workspace/ops-memory
source .env  # or export vars another way
python3 scripts/parlay_builder.py --date $(date -u +%F)
```
Outputs:
- `data/<DATE>/lines.json` (raw odds)
- `data/<DATE>/injuries.json`
- `analysis/<DATE>-parlay.md`

### Automation (planned)
Once the script is producing reports, wire it up to a systemd timer:
1. Create `/home/nate/.config/systemd/user/ops-memory-parlay.service` running the script.
2. Create `/home/nate/.config/systemd/user/ops-memory-parlay.timer` to run daily (e.g., 14:00 UTC).
3. `systemctl --user enable --now ops-memory-parlay.timer`

## Nightly auto-commit
The repo includes `autocommit.sh` and `ops-memory-autocommit.timer` to stage/commit/push changes each night at 23:55 UTC. Use `systemctl --user list-timers` to verify it is active.

## Restore script
If the workspace is rebuilt, run:
```
/home/nate/.openclaw/workspace/restore-memory.sh
```
to clone/pull the repo and recreate the symlinks.
