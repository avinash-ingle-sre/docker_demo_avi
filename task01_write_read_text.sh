#!/bin/bash
cat > /tmp/task01_write_read_text.py << 'PY'
#!/usr/bin/env python3
p = "/tmp/task01_notes.txt"
with open(p, "w", encoding="utf-8") as f:
    f.write("Line A\nLine B\nLine C\n")
print("Wrote", p)
with open(p, "r", encoding="utf-8") as f:
    for i, line in enumerate(f, 1):
        print(f"{i:02d}: {line.strip()}")
PY
python3 /tmp/task01_write_read_text.py
