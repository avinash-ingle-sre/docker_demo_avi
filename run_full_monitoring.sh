#!/bin/bash
# run_full_monitoring.sh - run a short monitoring simulation and produce insights
set -e

# Ensure metrics collector exists
if [ ! -x ./collect_metrics.sh ]; then
  echo "Missing scripts. Ensure collect_metrics.sh exists and is executable."
  exit 1
fi

# Clean previous labs artifacts (but keep metrics for demo)
mkdir -p /tmp/metrics
> /tmp/alerts.log
> /tmp/insights.txt

echo "Starting monitoring simulation (cycles: 6)"
for cycle in {1..6}; do
  echo "=== Cycle $cycle ==="
  ./collect_metrics.sh
  sleep 1
  ./detect_anomalies.sh || true
  ./predict_trends.sh || true
  ./correlate_events.sh || true

  # Simple rule: if alerts contain CRITICAL or predictions imminent -> run remediation
  if grep -q "CRITICAL" /tmp/alerts.log 2>/dev/null || grep -q "reach 100%" /tmp/alerts.log 2>/dev/null; then
    echo "Triggering safe remediation: cache_clear"
    ./remediation_controller.sh cache_clear || true
    echo "$(date '+%Y-%m-%d %H:%M:%S') REMEDIATION cache_clear" >> /tmp/alerts.log
  fi
done

# Produce insights summary
echo "=== INSIGHTS REPORT ===" > /tmp/insights.txt
echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')" >> /tmp/insights.txt
echo "" >> /tmp/insights.txt
echo "Recent alerts:" >> /tmp/insights.txt
tail -n 20 /tmp/alerts.log 2>/dev/null >> /tmp/insights.txt || true
echo "" >> /tmp/insights.txt
echo "Top metrics samples:" >> /tmp/insights.txt
ls -t /tmp/metrics/metrics_*.json 2>/dev/null | head -5 | while read f; do
  echo "File: $f" >> /tmp/insights.txt
  grep -E '"time"|"cpu"|"memory"|"disk"|"response_ms"|"error_rate"' "$f" | sed 's/^/  /' >> /tmp/insights.txt
  echo "" >> /tmp/insights.txt
done

echo "Insights written to /tmp/insights.txt"
cat /tmp/insights.txt
