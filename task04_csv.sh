#!/bin/bash
cat > /tmp/task04_csv.py << 'PY'
#!/usr/bin/env python3
import csv
from pathlib import Path
p = Path("/tmp/task04_users.csv")
rows = [
    {"name": "alice", "role": "dev"},
    {"name": "bob", "role": "ops"},
    {"name": "carol", "role": "qa"}
]
with p.open("w", newline='', encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=["name","role"])
    writer.writeheader()
    writer.writerows(rows)
print("Wrote CSV:", p)
with p.open("r", newline='', encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for r in reader:
        print(r)
PY
python3 /tmp/task04_csv.py
