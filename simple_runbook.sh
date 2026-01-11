#!/bin/bash
execute_runbook() {
    local service="$1"
    
    echo "📖 Running $service runbook"
    echo "========================="
    
    case "$service" in
        "api")
            echo "🔄 Restarting API services"
            echo "📊 Checking resource usage"
            echo "⚖️ Scaling if needed"
            ;;
        "database")
            echo "🔍 Checking connections"
            echo "📊 Analyzing slow queries" 
            echo "🔄 Restarting if needed"
            ;;
        "cache")
            echo "🧹 Clearing cache"
            echo "🔄 Restarting cache service"
            echo "📊 Verifying connections"
            ;;
        *)
            echo "🔄 Generic restart procedure"
            ;;
    esac
    
    echo "✅ Runbook completed"
}

echo "🛠️ Runbook Execution Test"
echo "========================"

execute_runbook "api"
echo
execute_runbook "database" 
echo
execute_runbook "unknown-service"
