#!/bin/bash
# detect_anomalies.sh - simple rules-based detector
METRICS_DIR="/tmp/metrics"
ALERTS_LOG="/tmp/alerts.log"
LATEST=$(ls -t "$METRICS_DIR"/metrics_*.json 2>/dev/null | head -1)

if [ -z "$LATEST" ]; then
  echo "No metrics found. Run generate_history.sh first."
  exit 1
fi

cpu=$(grep -o '"cpu": [0-9]\+' "$LATEST" | awk '{print $2}')
mem=$(grep -o '"memory": [0-9]\+' "$LATEST" | awk '{print $2}')
resp=$(grep -o '"response_ms": [0-9]\+' "$LATEST" | awk '{print $2}')
err=$(grep -o '"error_rate": [0-9]\+' "$LATEST" | awk '{print $2}')
time=$(grep -o '"time": "[^"]*"' "$LATEST" | sed 's/"time": "//;s/"//')

echo "Analyzing: $LATEST (time: $time)"
echo "  cpu=$cpu% mem=$mem% resp=${resp}ms err=${err}%"

# Baseline thresholds (teaching simple rules)
CPU_WARN=70
CPU_CRIT=85
MEM_WARN=75
MEM_CRIT=90
RESP_WARN=500
ERR_WARN=3

# Check and log
if [ "$cpu" -ge $CPU_CRIT ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') CRITICAL CPU $cpu%" | tee -a "$ALERTS_LOG"
elif [ "$cpu" -ge $CPU_WARN ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') WARNING CPU $cpu%" | tee -a "$ALERTS_LOG"
fi

if [ "$mem" -ge $MEM_CRIT ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') CRITICAL MEMORY $mem%" | tee -a "$ALERTS_LOG"
elif [ "$mem" -ge $MEM_WARN ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') WARNING MEMORY $mem%" | tee -a "$ALERTS_LOG"
fi

if [ "$resp" -ge $RESP_WARN ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') WARNING RESPONSE ${resp}ms" | tee -a "$ALERTS_LOG"
fi

if [ "$err" -gt $ERR_WARN ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') WARNING ERROR_RATE ${err}%" | tee -a "$ALERTS_LOG"
fi

echo "Detection complete. Alerts log: $ALERTS_LOG"
