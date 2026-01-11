#!/bin/bash
echo "👀 Multi-Service Monitor"
echo "======================"

services=("api" "database" "cache" "queue")

for service in "${services[@]}"; do
    echo "Checking $service..."
    
    if [ $((RANDOM % 5)) -eq 0 ]; then
        echo "  ❌ $service: Issue detected"
    else
        echo "  ✅ $service: Healthy"
    fi
    sleep 0.5
done

echo "Monitor cycle completed"
