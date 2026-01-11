#!/bin/bash
# remediation_disk_cleanup.sh - simulated safe disk cleanup
echo "Simulated remediation: removing old tmp files (safe)"
find /tmp -maxdepth 1 -type f -name '*.tmp' -mtime +1 -print -delete 2>/dev/null || true
echo "Disk cleanup simulated"
