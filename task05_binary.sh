#!/bin/bash
cat > /tmp/task05_binary.py << 'PY'
#!/usr/bin/env python3
from pathlib import Path
p = Path("/tmp/task05_sample.bin")
content = bytes(range(0, 256))
p.write_bytes(content)
print("Wrote binary file size:", p.stat().st_size)
with p.open("rb") as f:
    print("First 8 bytes:", f.read(8))
PY
python3 /tmp/task05_binary.py
