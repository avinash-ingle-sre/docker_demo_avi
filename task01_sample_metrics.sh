#!/bin/bash
LOG=/tmp/sys_metrics.log
timestamp(){ date '+%Y-%m-%d %H:%M:%S'; }
cpu=$(top -bn1 2>/dev/null | awk '/Cpu\(s\)/ {print $2}' 2>/dev/null | sed 's/,/./' | awk '{printf("%.0f",$1)}' || echo 5)
mem=$(free 2>/dev/null | awk '/Mem:/ {printf("%.0f",$3/$2 * 100)}' || echo 30)
disk=$(df / 2>/dev/null | tail -1 | awk '{print $5}' | sed 's/%//' || echo 10)
echo "$(timestamp) CPU:${cpu}% MEM:${mem}% DISK:${disk}%" >> "$LOG"
echo "Wrote metrics to $LOG"
