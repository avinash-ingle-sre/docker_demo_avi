#!/bin/bash
# usage: /tmp/task05_retry.sh <attempts> <delay> -- <command...>
attempts="${1:-3}"; delay="${2:-1}"; shift 2
# if '--' used, account for it
if [ "$1" = "--" ]; then shift; fi
i=1
while [ $i -le $attempts ]; do
  if "$@"; then
    # In lab environment, don't exit - just return success
    return 0 2>/dev/null || break
  fi
  echo "Attempt $i failed, sleeping $delay..."
  sleep "$delay"
  i=$((i+1))
done
echo "All attempts failed"
# In lab environment, don't exit - just return error
return 1 2>/dev/null || echo "Failed"
