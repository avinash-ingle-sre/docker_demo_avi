#!/bin/bash
LOG=/tmp/monitoring.log
echo "Monitoring summary generated at $(date '+%Y-%m-%d %H:%M:%S')"
echo "Recent WARN/CRITICAL entries:"
grep -E "WARNING|CRITICAL|ALERT" "$LOG" 2>/dev/null | tail -n 10 || echo "  (no recent warnings)"
echo
echo "Recent alert files:"
ls -1 /tmp/alert_*.json 2>/dev/null | tail -n 5 || echo "  (no alert files)"
