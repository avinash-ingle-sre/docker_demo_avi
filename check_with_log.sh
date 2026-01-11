#!/bin/bash
LOG_FILE="service_check.log"

log_check() {
    local service="$1"
    local status="$2"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    
    echo "[$timestamp] $service: $status" >> "$LOG_FILE"
    echo "[$timestamp] $service: $status"
}

service="database"
if [ $((RANDOM % 4)) -eq 0 ]; then
    log_check "$service" "FAILED"
else
    log_check "$service" "OK"
fi

echo "Log entries:"
tail -n 3 "$LOG_FILE"
