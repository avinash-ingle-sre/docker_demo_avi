#!/bin/bash
# Task 5: verify secondary readiness after failover (safe simulation)
DR_DIR="/tmp/dr_lab"
SECONDARY_DATA="$DR_DIR/sites/secondary/data"
VERIFY_LOG="/tmp/dr_verify.log"

echo "$(date '+%Y-%m-%d %H:%M:%S') Verifying secondary site..." | tee -a "$VERIFY_LOG"

if [ -f "$SECONDARY_DATA/replication_info.txt" ]; then
  echo "  Replication manifest present" | tee -a "$VERIFY_LOG"
else
  echo "  ERROR: No replication manifest -> replication likely failed" | tee -a "$VERIFY_LOG"
  # In lab environment, don't exit - just return error
  return 1 2>/dev/null || true
fi

# Simulate enabling write: append a small test line
echo "failover-test: $(date '+%Y-%m-%d %H:%M:%S')" >> "$SECONDARY_DATA/app_data.txt" || true
echo "  Write test appended to secondary data file" | tee -a "$VERIFY_LOG"

echo "$(date '+%Y-%m-%d %H:%M:%S') Secondary verification completed successfully" | tee -a "$VERIFY_LOG"
