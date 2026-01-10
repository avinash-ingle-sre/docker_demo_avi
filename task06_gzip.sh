#!/bin/bash
cat > /tmp/task06_gzip.py << 'PY'
#!/usr/bin/env python3
import gzip
from pathlib import Path
src = Path("/tmp/task01_notes.txt")
dst = Path("/tmp/task06_notes.txt.gz")
with src.open("rb") as s, gzip.open(dst, "wb") as g:
    g.writelines(s)
print("Compressed to", dst)
# read back first line without writing to disk
with gzip.open(dst, "rt", encoding="utf-8") as g:
    print("First line:", g.readline().strip())
PY
python3 /tmp/task06_gzip.py
