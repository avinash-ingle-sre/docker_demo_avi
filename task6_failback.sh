#!/bin/bash
# Task 6: failback simulation - sync secondary -> primary and restore DNS
DR_DIR="/tmp/dr_lab"
FAILOVER_LOG="/tmp/dr_failover.log"
DNS_FILE="/tmp/dr_lab/dns_current.txt"

echo "$(date '+%Y-%m-%d %H:%M:%S') Starting failback..." | tee -a "$FAILOVER_LOG"

# Copy secondary data back to primary (safe simulation)
cp -a "$DR_DIR/sites/secondary/data/." "$DR_DIR/sites/primary/data/" 2>/dev/null || true
echo "$(date '+%Y-%m-%d %H:%M:%S') Data synchronized secondary -> primary (simulated)" | tee -a "$FAILOVER_LOG"

# Restore DNS to primary
echo "app.example.local -> primary" > "$DNS_FILE"
echo "$(date '+%Y-%m-%d %H:%M:%S') DNS restored to primary" | tee -a "$FAILOVER_LOG"

# Remove promotion marker
rm -f /tmp/dr_lab/secondary_promoted.marker
echo "$(date '+%Y-%m-%d %H:%M:%S') Failback complete" | tee -a "$FAILOVER_LOG"
