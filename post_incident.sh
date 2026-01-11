#!/bin/bash
generate_postmortem() {
    local incident_id="$1"
    local service="$2" 
    local duration="$3"
    
    cat > "postmortem_$incident_id.md" << REPORT
# Post-Incident Report: $incident_id

## Summary
- Service: $service
- Duration: $duration minutes
- Impact: Service degradation
- Root Cause: High load during peak hours

## Timeline
- **00:00** - Anomaly detected by monitoring
- **00:02** - Automated alert triggered
- **00:05** - Engineer notified
- **00:10** - Investigation started
- **00:15** - Root cause identified
- **00:$duration** - Service restored

## Actions Taken
- ✅ Scaled service horizontally
- ✅ Optimized database queries
- ✅ Increased connection pool size
- ✅ Updated monitoring thresholds

## Lessons Learned
1. Need better capacity planning
2. Monitoring thresholds too high
3. Runbook worked effectively

## Action Items
- [ ] Review capacity planning (Due: Next week)
- [ ] Update monitoring config (Due: 3 days)
- [ ] Conduct team retrospective (Due: Friday)

---
Generated: $(date)
REPORT
    
    echo "📋 Post-mortem generated: postmortem_$incident_id.md"
}

echo "📝 Post-Incident Analysis"
echo "========================"

generate_postmortem "INC-001" "payment-api" "25"
generate_postmortem "INC-002" "user-auth" "12"

echo "Generated reports:"
ls postmortem_*.md
