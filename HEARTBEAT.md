# HEARTBEAT
Purpose: On each heartbeat ping, run a short ops checklist and record results.

## Checklist (run every ping)
1) Confirm workspace present and writable.
2) Confirm upload sorter:
   - systemctl --user is-active sort-inbox.timer
   - journalctl --user -u sort-inbox.service -n 20
3) Confirm preview port (optional):
   - ss -lntp | grep :8080 || true
4) Update memory:
   - append 3–7 bullets to /home/nate/.openclaw/workspace/memory/YYYY-MM-DD.md
5) Log:
   - append UTC timestamp + summary to /home/nate/.openclaw/workspace/logs/heartbeat.log

## Output contract
Only reply "HEARTBEAT_OK" after completing checklist + writing log line.
