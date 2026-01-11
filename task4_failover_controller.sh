#!/bin/bash
# Task 4: failover controller - checks health and promotes secondary if primary unhealthy
DR_DIR="/tmp/dr_lab"
FAILOVER_LOG="/tmp/dr_failover.log"
DNS_FILE="/tmp/dr_lab/dns_current.txt"

# Helper to record DNS-like mapping (safe simulation)
set_dns_to() {
  local target="$1"
  echo "app.example.local -> $target" > "$DNS_FILE"
  echo "$(date '+%Y-%m-%d %H:%M:%S') DNS pointed to $target" | tee -a "$FAILOVER_LOG"
}

# Use the health check script
./task2_health_check.sh >/tmp/dr_health.out 2>&1
PRIMARY_RC=$?

if [ $PRIMARY_RC -eq 0 ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') PRIMARY healthy; no failover" | tee -a "$FAILOVER_LOG"
  set_dns_to primary
  # In lab environment, don't exit - just return
  return 0 2>/dev/null || true
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') PRIMARY unhealthy - initiating failover" | tee -a "$FAILOVER_LOG"
# Ensure data replicated before failover
./task3_replicate.sh
# Redirect traffic (simulated DNS update)
set_dns_to secondary

# mark promotion
touch /tmp/dr_lab/secondary_promoted.marker
echo "$(date '+%Y-%m-%d %H:%M:%S') Secondary promoted to primary (simulated)" | tee -a "$FAILOVER_LOG"
