#!/bin/bash
echo "🔍 Service Status Check"
echo "======================"

service_name="web-api"
echo "Checking $service_name..."

# Simulate service check
if [ $((RANDOM % 3)) -eq 0 ]; then
    echo "❌ $service_name: DOWN"
    # In lab environment, don't exit - just return error
    return 1 2>/dev/null || true
else
    echo "✅ $service_name: UP"
    # In lab environment, don't exit - just return success
    return 0 2>/dev/null || true
fi
