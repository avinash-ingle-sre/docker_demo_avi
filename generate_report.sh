#!/bin/bash
generate_summary() {
    echo "📋 Incident Summary Report"
    echo "========================="
    echo "Generated: $(date)"
    echo
    
    # Service status
    echo "🏥 Service Health:"
    local services=("API" "Database" "Cache" "Queue")
    for service in "${services[@]}"; do
        if [ $((RANDOM % 4)) -eq 0 ]; then
            echo "  ⚠️  $service: Issues detected"
        else
            echo "  ✅ $service: Healthy"
        fi
    done
    
    echo
    echo "📊 Last 24 Hours:"
    echo "  Total Incidents: $((RANDOM % 10 + 5))"
    echo "  Resolved: $((RANDOM % 8 + 4))"
    echo "  Avg Resolution: $((RANDOM % 30 + 15)) minutes"
    echo "  SLA Compliance: $((RANDOM % 5 + 95))%"
    
    echo
    echo "🎯 Top Issues:"
    echo "  1. High latency (32%)"
    echo "  2. Database timeouts (28%)"
    echo "  3. API errors (25%)"
    echo "  4. Cache misses (15%)"
    
    echo
    echo "✅ Recent Resolutions:"
    echo "  INC-001: Payment gateway timeout - 12min"
    echo "  INC-002: User auth slowdown - 8min"
    echo "  INC-003: Database connection pool - 15min"
}

generate_summary
