#!/bin/bash
cat > /tmp/task03_json_rw.py << 'PY'
#!/usr/bin/env python3
import json
from pathlib import Path
p = Path("/tmp/task03_config.json")
data = {"app": "demo", "replicas": 2, "features": {"x": True}}
p.write_text(json.dumps(data, indent=2), encoding="utf-8")
print("Wrote", p)
loaded = json.loads(p.read_text(encoding="utf-8"))
print("Read back equal?", loaded == data)
PY
python3 /tmp/task03_json_rw.py
