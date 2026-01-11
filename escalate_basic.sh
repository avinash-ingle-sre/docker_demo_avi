#!/bin/bash
escalate() {
    local incident_id="$1"
    local severity="$2"
    
    echo "📢 Escalating $incident_id ($severity)"
    
    case "$severity" in
        "P0-CRITICAL")
            echo "🚨 CRITICAL: Calling all hands!"
            echo "  📱 SMS: +1-555-ONCALL"
            echo "  📧 Email: critical@company.com"
            ;;
        "P1-HIGH")
            echo "⚡ HIGH: PagerDuty alert sent"
            echo "  💬 Slack: #incidents"
            ;;
        "P2-MEDIUM"|"P3-LOW")
            echo "📧 Standard notification sent"
            ;;
    esac
}

echo "🚨 Escalation Test"
echo "================="

escalate "INC-001" "P0-CRITICAL"
echo
escalate "INC-002" "P1-HIGH"
echo  
escalate "INC-003" "P2-MEDIUM"
