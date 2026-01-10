#!/bin/bash
LOG=/tmp/monitoring_events.log
ts(){ date '+%Y-%m-%d %H:%M:%S'; }
level="${1:-INFO}"
shift || true
msg="$*"
printf "%s [%s] %s\n" "$(ts)" "$level" "$msg" >> "$LOG"
echo "Logged: $level $msg"
