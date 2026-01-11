#!/bin/bash
create_incident() {
    local id="$1"
    local service="$2"
    local status="$3"
    
    cat > "incident_$id.json" << JSON
{
  "id": "$id",
  "service": "$service", 
  "status": "$status",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
JSON
    
    echo "✅ Incident $id logged"
}

echo "📝 Incident Logger"
echo "================"

incident_id="INC-001"
create_incident "$incident_id" "payment-api" "detected"

echo "Created file: incident_$incident_id.json"
cat "incident_$incident_id.json"
