#!/bin/bash
detect_incidents() {
    echo "🔍 Automated Incident Detection"
    echo "==============================="
    
    local services=("payment" "auth" "inventory" "orders")
    
    for service in "${services[@]}"; do
        echo "Scanning $service..."
        
        # Simulate detection with different thresholds
        local metric_value=$((RANDOM % 100))
        
        if [ $metric_value -gt 90 ]; then
            echo "🚨 CRITICAL: $service metric at $metric_value%"
            create_alert "$service" "critical" "$metric_value"
        elif [ $metric_value -gt 80 ]; then
            echo "⚠️  WARNING: $service metric at $metric_value%"
            create_alert "$service" "warning" "$metric_value"
        else
            echo "✅ NORMAL: $service metric at $metric_value%"
        fi
    done
}

create_alert() {
    local service="$1"
    local level="$2"
    local value="$3"
    
    echo "[$(date)] ALERT: $service $level (metric: $value%)" >> alerts.log
    echo "Alert logged for $service"
}

detect_incidents

echo
echo "Generated alerts:"
if [ -f alerts.log ]; then
    cat alerts.log
else
    echo "No alerts generated"
fi
