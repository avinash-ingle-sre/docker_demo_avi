#!/bin/bash
set -e

PIDS_DIR="pids"
SERVICES_DIR="services"
LOGS_DIR="logs"

# Start a single service
start_service() {
    local service_name=\$1
    echo "Starting \$service_name..."
    nohup ./${SERVICES_DIR}/${service_name}.sh > "\${LOGS_DIR}/${service_name}.log" 2>&1 &
    echo \$! > "\${PIDS_DIR}/${service_name}.pid"
}

# Stop a single service
stop_service() {
    local service_name=\$1
    local pid_file="\${PIDS_DIR}/${service_name}.pid"
    if [ -f "\$pid_file" ]; then
        local pid=\$(cat "\$pid_file")
        echo "Stopping \${service_name} (PID: \${pid})..."
        kill \$pid
        rm "\$pid_file"
    fi
}

start() {
    start_service "database"
    sleep 1 # Simple health check
    start_service "api"
    sleep 1
    start_service "web"
}

stop() {
    # Stop in reverse order
    stop_service "web"
    stop_service "api"
    stop_service "database"
}

status() {
    for service in database api web; do
        local pid_file="${PIDS_DIR}/${service}.pid"
        if [ -f "$pid_file" ] && kill -0 $(cat $pid_file) >/dev/null 2>&1; then
            echo "[\${service}] RUNNING"
        else
            echo "[\${service}] STOPPED"
        fi
    done
}

case "\$1" in
    start) start ;;
    stop) stop ;;
    status) status ;;
    *) echo "Usage: \$0 {start|stop|status}"; exit 1 ;;
esac
