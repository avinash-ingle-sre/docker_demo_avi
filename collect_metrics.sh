#!/bin/bash
collect_metrics() {
    echo "📊 Incident Metrics"
    echo "=================="
    
    local total_incidents=0
    local resolved_incidents=0
    
    # Count incident files
    if ls incident_*.json >/dev/null 2>&1; then
        total_incidents=$(ls incident_*.json | wc -l)
        resolved_incidents=$(grep -l '"status": "resolved"' incident_*.json 2>/dev/null | wc -l)
    fi
    
    echo "Total Incidents: $total_incidents"
    echo "Resolved: $resolved_incidents"
    echo "Active: $((total_incidents - resolved_incidents))"
    
    if [ $total_incidents -gt 0 ]; then
        local resolution_rate=$(( (resolved_incidents * 100) / total_incidents ))
        echo "Resolution Rate: $resolution_rate%"
    fi
    
    echo "System Status: $([ $((total_incidents - resolved_incidents)) -eq 0 ] && echo "🟢 All Clear" || echo "🟡 Active Incidents")"
}

echo "📈 Metrics Collection Test"
echo "========================="

# Create sample incidents
cat > incident_DEMO-001.json << 'EOF'
{"id": "DEMO-001", "status": "resolved"}
