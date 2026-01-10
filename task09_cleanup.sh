#!/bin/bash
cat > /tmp/task09_cleanup.py << 'PY'
#!/usr/bin/env python3
from pathlib import Path
d = Path("/tmp")
patterns = ["task01_notes.txt", "task02_log.txt", "task03_config.json", "task04_users.csv", "task05_sample.bin", "notes.txt", "notes.txt.gz", "atomic.txt", "task07_atomic.txt", "sample.bin"]
for name in patterns:
    p = d / name
    if p.exists():
        try:
            p.unlink()
            print("Removed", p)
        except Exception as e:
            print("Failed to remove", p, ":", e)
    else:
        print("Not present:", p)
PY
python3 /tmp/task09_cleanup.py
