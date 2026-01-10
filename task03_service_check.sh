#!/bin/bash
LOG=/tmp/service_checks.log
name="${1:-service}"
host="${2:-localhost}"
port="${3:-80}"
ts(){ date '+%Y-%m-%d %H:%M:%S'; }
if command -v nc >/dev/null 2>&1; then
  if nc -z -w 1 "$host" "$port" 2>/dev/null; then
    echo "$(ts) [OK] $name $host:$port" >> "$LOG"
    # In lab environment, don't exit - just return success
    return 0 2>/dev/null || echo "OK"
  else
    echo "$(ts) [FAIL] $name $host:$port" >> "$LOG"
    # In lab environment, don't exit - just return error
    return 2 2>/dev/null || echo "FAIL"
  fi
else
  if (echo > /dev/tcp/$host/$port) >/dev/null 2>&1; then
    echo "$(ts) [OK] $name $host:$port" >> "$LOG"
    # In lab environment, don't exit - just return success
    return 0 2>/dev/null || echo "OK"
  else
    echo "$(ts) [FAIL] $name $host:$port (no nc)" >> "$LOG"
    # In lab environment, don't exit - just return error
    return 2 2>/dev/null || echo "FAIL"
  fi
fi
