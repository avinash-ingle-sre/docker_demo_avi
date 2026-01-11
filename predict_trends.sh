#!/bin/bash
# predict_trends.sh - naive trend projection for disk and memory
METRICS_DIR="/tmp/metrics"
LATEST_N=5
FILES=($(ls -t "$METRICS_DIR"/metrics_*.json 2>/dev/null | head -n $LATEST_N))
if [ "${#FILES[@]}" -lt 2 ]; then
  echo "Not enough samples. Run generate_history.sh to create metrics."
  exit 1
fi

# collect numeric arrays
mem_values=()
disk_values=()
for f in "${FILES[@]}"; do
  mem=$(grep -o '"memory": [0-9]\+' "$f" | awk '{print $2}')
  disk=$(grep -o '"disk": [0-9]\+' "$f" | awk '{print $2}')
  mem_values+=($mem)
  disk_values+=($disk)
done

# simple growth rate: last - first divided by (n-1)
mem_first=${mem_values[-1]}
mem_last=${mem_values[0]}
mem_rate=$((mem_last - mem_first))
disk_first=${disk_values[-1]}
disk_last=${disk_values[0]}
disk_rate=$((disk_last - disk_first))

echo "Memory: first=$mem_first last=$mem_last rate=$mem_rate per ~sample"
echo "Disk:   first=$disk_first last=$disk_last rate=$disk_rate per ~sample"

# project days until 100% (assume samples ~1 minute apart; convert heuristically)
if [ "$mem_rate" -le 0 ]; then
  echo "Memory stable or decreasing - no immediate exhaustion predicted"
else
  # avoid division by zero
  days=$(( (100 - mem_last) / (mem_rate + 1) ))
  echo "Prediction: Memory may reach 100% in ~$days cycles (heuristic)"
fi

if [ "$disk_rate" -le 0 ]; then
  echo "Disk stable or decreasing - no immediate exhaustion predicted"
else
  days=$(( (100 - disk_last) / (disk_rate + 1) ))
  echo "Prediction: Disk may reach 100% in ~$days cycles (heuristic)"
fi
