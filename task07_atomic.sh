#!/bin/bash
cat > /tmp/task07_atomic.py << 'PY'
#!/usr/bin/env python3
import os
from pathlib import Path
tgt = Path("/tmp/task07_atomic.txt")
tmp = tgt.with_suffix(".tmp")
with tmp.open("w", encoding="utf-8") as f:
    f.write("Atomic content at write time\n")
# atomic replace
os.replace(tmp, tgt)
print("Atomic replace done:", tgt)
PY
python3 /tmp/task07_atomic.py
