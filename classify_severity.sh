#!/bin/bash
classify_severity() {
    local service="$1"
    
    case "$service" in
        "payment"|"billing"|"checkout")
            echo "P0-CRITICAL"
            ;;
        "user-auth"|"api-gateway") 
            echo "P1-HIGH"
            ;;
        "notifications"|"analytics")
            echo "P2-MEDIUM" 
            ;;
        *)
            echo "P3-LOW"
            ;;
    esac
}

echo "🎯 Severity Classification"
echo "========================="

services=("payment" "user-auth" "notifications" "reports" "billing")

for service in "${services[@]}"; do
    severity=$(classify_severity "$service")
    echo "$service -> $severity"
done
