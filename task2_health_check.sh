#!/bin/bash
# Task 2: health checks (simulated)
SITES_DIR="/tmp/dr_lab/sites"
timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

# Simulate check: returns 0 (healthy) or 1 (unhealthy)
site_health() {
  local site="$1"
  # For exercise: primary fails randomly 20% of the time, secondary mostly healthy
  if [ "$site" = "primary" ]; then
    if [ $((RANDOM % 10)) -lt 2 ]; then
      echo "$(timestamp) $site: database CHECK FAILED"
      return 1
    fi
  fi
  echo "$(timestamp) $site: ALL CHECKS PASS"
  return 0
}

# Example usage
echo "Running site health checks..."
site_health primary; RC1=$?
site_health secondary; RC2=$?
echo "primary rc=$RC1 secondary rc=$RC2"
exit $((RC1 || RC2))
