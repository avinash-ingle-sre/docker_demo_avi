#!/bin/bash
cat > /tmp/task02_append_overwrite.py << 'PY'
#!/usr/bin/env python3
p = "/tmp/task02_log.txt"
# overwrite
with open(p, "w", encoding="utf-8") as f:
    f.write("Start log\n")
# append
with open(p, "a", encoding="utf-8") as f:
    f.write("Appended line 1\n")
    f.write("Appended line 2\n")
with open(p, "r", encoding="utf-8") as f:
    print(f.read())
PY
python3 /tmp/task02_append_overwrite.py
