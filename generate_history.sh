#!/bin/bash
# generate_history.sh - generate multiple metric samples for baseline
for i in {1..8}; do
  ./collect_metrics.sh
  sleep 1
done
echo "Generated metric history (8 samples)"
