#!/bin/bash
generate_id() {
    local date_part=$(date +%Y%m%d)
    local time_part=$(date +%H%M)
    local random_part=$(printf '%03d' $((RANDOM % 1000)))
    
    echo "INC-$date_part-$time_part-$random_part"
}

echo "🆔 Incident ID Generator"
echo "======================"

for i in {1..5}; do
    incident_id=$(generate_id)
    echo "Generated ID $i: $incident_id"
    sleep 0.1
done
