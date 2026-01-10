#!/bin/bash
cat > /tmp/task08_metadata.py << 'PY'
#!/usr/bin/env python3
from pathlib import Path
from datetime import datetime
p = Path("/tmp/task01_notes.txt")
if not p.exists():
    print("File missing:", p)
else:
    st = p.stat()
    print("Size:", st.st_size)
    print("Modified:", datetime.fromtimestamp(st.st_mtime).isoformat())
    try:
        p.chmod(0o640)
        print("Set mode to 0640")
    except Exception as e:
        print("Could not change mode:", e)
PY
python3 /tmp/task08_metadata.py
