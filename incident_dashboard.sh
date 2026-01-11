#!/bin/bash
show_dashboard() {
    clear
    echo "🚨 Incident Response Dashboard"
    echo "=============================="
    echo "Last Updated: $(date)"
    echo
    
    # System overview
    echo "🏥 System Status Overview"
    echo "------------------------"
    
    local systems=("Payment Gateway" "User Service" "Order DB" "Inventory API")
    for system in "${systems[@]}"; do
        if [ $((RANDOM % 6)) -eq 0 ]; then
            echo "  🔴 $system: DOWN"
        elif [ $((RANDOM % 4)) -eq 0 ]; then
            echo "  🟡 $system: DEGRADED"
        else
            echo "  🟢 $system: HEALTHY"
        fi
    done
    
    echo
    echo "📊 Current Incidents"
    echo "-------------------"
    
    local active_count=$((RANDOM % 4))
    if [ $active_count -eq 0 ]; then
        echo "  🎉 No active incidents!"
    else
        for i in $(seq 1 $active_count); do
            local severity=("P0" "P1" "P2")
            local sel_severity=${severity[$((RANDOM % 3))]}
            echo "  🚨 INC-00$i: $sel_severity - Under investigation"
        done
    fi
    
    echo
    echo "⚡ Response Team"
    echo "---------------"
    echo "  👤 On-call Engineer: Available"
    echo "  👤 SRE Lead: Available"
    echo "  👤 Manager: In meeting"
    
    echo
    echo "📈 Today's Statistics"
    echo "--------------------"
    echo "  Incidents: $((RANDOM % 8 + 2))"
    echo "  Resolved: $((RANDOM % 6 + 2))"
    echo "  Avg Resolution: $((RANDOM % 20 + 10))min"
    echo "  SLA Met: $((RANDOM % 10 + 90))%"
}

show_dashboard
