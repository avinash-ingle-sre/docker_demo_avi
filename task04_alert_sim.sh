#!/bin/bash
severity="${1:-WARNING}"
message="${2:-Test alert}"
ts=$(date +%s)
outfile="/tmp/alert_${ts}.json"
cat > "$outfile" <<JSON
{
  "timestamp": "$(date '+%Y-%m-%d %H:%M:%S')",
  "severity": "$severity",
  "message": "$message",
  "host": "$(hostname -f 2>/dev/null || hostname)"
}
JSON
echo "Alert written to $outfile"
