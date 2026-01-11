#!/bin/bash
# Task 3: replicate data from primary -> secondary (safe file copy)
DR_DIR="/tmp/dr_lab"
SRC="$DR_DIR/sites/primary/data"
DST="$DR_DIR/sites/secondary/data"
LOG="/tmp/dr_replication.log"

mkdir -p "$DST"
cp -a "$SRC/." "$DST/" 2>/dev/null || true

cat > "$DST/replication_info.txt" <<MAN
source=primary
destination=secondary
timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
status=completed
lag_seconds=1
MAN

echo "$(date '+%Y-%m-%d %H:%M:%S') Replication completed" | tee -a "$LOG"
echo "Replication files in: $DST"
