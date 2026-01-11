#!/bin/bash
# remediation_controller.sh - run remediation based on inputs
ACTION="$1"
case "$ACTION" in
  cache_clear)
    ./remediation_cache_clear.sh
    ;;
  disk_cleanup)
    ./remediation_disk_cleanup.sh
    ;;
  *)
    echo "Usage: $0 {cache_clear|disk_cleanup}"
    exit 1
    ;;
esac
