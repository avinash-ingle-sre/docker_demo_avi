#!/bin/bash
update_status() {
    local incident_id="$1"
    local new_status="$2"
    local file="incident_$incident_id.json"
    
    if [ ! -f "$file" ]; then
        echo "❌ Incident $incident_id not found"
        return 1
    fi
    
    # Simple status update (in production, use jq)
    sed -i "s/"status": "[^"]*"/"status": "$new_status"/" "$file"
    
    echo "✅ Updated $incident_id to $new_status"
    echo "[$(date)] $incident_id -> $new_status" >> status_updates.log
}

echo "📊 Status Tracking"
echo "=================="

# Create test incident
cat > incident_TEST-001.json << 'EOF'
{
  "id": "TEST-001",
  "service": "api",
  "status": "detected",
  "timestamp": "2024-01-01T12:00:00Z"
}
