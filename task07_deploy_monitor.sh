#!/bin/bash
cat > /tmp/integrated_monitor.sh <<'SCRIPT'
#!/bin/bash
# /tmp/integrated_monitor.sh
# Lightweight integrated monitoring demo (logs to /tmp/monitoring.log)
# Designed for small VMs (1 CPU / 2GB RAM) — all checks are lightweight and simulated.

LOG_FILE="/tmp/monitoring.log"
mkdir -p "$(dirname "$LOG_FILE")"

timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

log() {
  local level="$1"; shift
  printf "%s [%s] %s\n" "$(timestamp)" "$level" "$*" | tee -a "$LOG_FILE"
}

check_cpu() {
  # light-weight CPU snapshot (use top in batch mode if available)
  if command -v mpstat >/dev/null 2>&1; then
    cpu_idle=$(mpstat 1 1 2>/dev/null | awk '/all/ {print $12}' | tail -1)
    cpu_usage=$(awk "BEGIN {printf "%.0f", 100 - ($cpu_idle)}")
  else
    cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print $2}' 2>/dev/null | sed 's/,/./' | awk '{printf("%.0f",$1)}' || echo 5)
  fi
  log "INFO" "CPU Usage: ${cpu_usage}%"
  if [ "$cpu_usage" -gt 90 ]; then
    log "CRITICAL" "CPU > 90% (${cpu_usage}%)"
  elif [ "$cpu_usage" -gt 70 ]; then
    log "WARNING" "CPU > 70% (${cpu_usage}%)"
  fi
}

check_memory() {
  # use free if available
  if command -v free >/dev/null 2>&1; then
    mem_usage=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}' 2>/dev/null || echo 30)
  else
    mem_usage=30
  fi
  log "INFO" "Memory Usage: ${mem_usage}%"
  if [ "$mem_usage" -gt 95 ]; then
    log "CRITICAL" "Memory > 95% (${mem_usage}%)"
  elif [ "$mem_usage" -gt 80 ]; then
    log "WARNING" "Memory > 80% (${mem_usage}%)"
  fi
}

check_disk() {
  # check root disk usage (lightweight)
  disk_usage=$(df / 2>/dev/null | tail -1 | awk '{print $5}' | sed 's/%//' || echo 10)
  log "INFO" "Disk Usage (/): ${disk_usage}%"
  if [ "$disk_usage" -gt 90 ]; then
    log "CRITICAL" "Disk > 90% (${disk_usage}%)"
  elif [ "$disk_usage" -gt 80 ]; then
    log "WARNING" "Disk > 80% (${disk_usage}%)"
  fi
}

service_check_port() {
  local name="$1"
  local host="$2"
  local port="$3"
  if command -v nc >/dev/null 2>&1; then
    if nc -z -w 1 "$host" "$port" 2>/dev/null; then
      log "INFO" "Service ${name} on ${host}:${port} is UP"
      return 0
    else
      log "CRITICAL" "Service ${name} on ${host}:${port} is DOWN"
      return 1
    fi
  else
    # fallback: attempt TCP connection via bash /dev/tcp (may not be enabled)
    if (echo > /dev/tcp/${host}/${port}) >/dev/null 2>&1; then
      log "INFO" "Service ${name} on ${host}:${port} is UP"
      return 0
    else
      log "CRITICAL" "Service ${name} on ${host}:${port} is DOWN (nc missing)"
      return 1
    fi
  fi
}

send_alert() {
  # Lightweight alert simulation: write a JSON blob to /tmp/alert_*.json
  local severity="$1"
  local message="$2"
  local ts=$(date +%s)
  cat > "/tmp/alert_${ts}.json" <<-ALERT
{
  "timestamp": "$(timestamp)",
  "severity": "${severity}",
  "message": "${message}",
  "host": "$(hostname -f 2>/dev/null || hostname)"
}
ALERT
  log "ALERT" "${severity}: ${message} (saved /tmp/alert_${ts}.json)"
}

# Lightweight retry helper (bash function)
retry_cmd() {
  local attempts=$1; shift
  local delay=$1; shift
  local cmd=("$@")
  local i=1
  while [ $i -le $attempts ]; do
    "${cmd[@]}" && return 0
    i=$((i+1))
    sleep "$delay"
  done
  return 1
}

generate_summary() {
  printf "\n==== Monitoring Summary (%s) ====" "$(timestamp)" | tee -a "$LOG_FILE"
  grep -E "CRITICAL|WARNING" "$LOG_FILE" | tail -n 10 | sed 's/^/  /' | tee -a "$LOG_FILE"
  printf "\nRecent alerts: \n" | tee -a "$LOG_FILE"
  ls -1 /tmp/alert_*.json 2>/dev/null | tail -n 5 | sed 's/^/  /' | tee -a "$LOG_FILE"
}

# Main: perform checks (keeps light resource footprint)
check_cpu
check_memory
check_disk

# Example service checks (adjust to your environment or simulate)
service_check_port "ssh" "localhost" 22 || send_alert "CRITICAL" "ssh port unreachable"
service_check_port "http" "localhost" 80 || send_alert "WARNING" "http port unreachable"

# Example retry usage: try to curl a health endpoint (simulated)
if command -v curl >/dev/null 2>&1; then
  retry_cmd 3 1 curl -sSf http://localhost:8080/health >/dev/null 2>&1 || log "INFO" "Health endpoint not reachable or not present"
fi

generate_summary
# In lab environment, don't exit - just show completion
echo "Monitoring script completed"

SCRIPT
chmod +x /tmp/integrated_monitor.sh
echo "Integrated monitor deployed to /tmp/integrated_monitor.sh"
