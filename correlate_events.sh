#!/bin/bash
# correlate_events.sh - check simple correlations over last 5 metrics
METRICS_DIR="/tmp/metrics"
FILES=($(ls -t "$METRICS_DIR"/metrics_*.json 2>/dev/null | head -n 5))
if [ "${#FILES[@]}" -lt 3 ]; then
  echo "Not enough data to correlate. Generate more metrics."
  exit 1
fi

high_cpu_count=0
high_resp_count=0
for f in "${FILES[@]}"; do
  cpu=$(grep -o '"cpu": [0-9]\+' "$f" | awk '{print $2}')
  resp=$(grep -o '"response_ms": [0-9]\+' "$f" | awk '{print $2}')
  [ "$cpu" -gt 65 ] && ((high_cpu_count++))
  [ "$resp" -gt 400 ] && ((high_resp_count++))
done

echo "Over last ${#FILES[@]} samples: high_cpu=$high_cpu_count high_resp=$high_resp_count"

# if both counters are high, report correlation
if [ "$high_cpu_count" -ge 2 ] && [ "$high_resp_count" -ge 2 ]; then
  echo "CORRELATION: High CPU often occurs with high response times - likely cause: CPU saturation"
else
  echo "No strong correlation detected"
fi
