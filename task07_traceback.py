#!/usr/bin/env python3
import traceback
def inner():
    raise ValueError("inner failure")
def outer():
    inner()
try:
    outer()
except Exception as e:
    tb = traceback.format_exc()
    with open('/tmp/task07_traceback.log','w') as f:
        f.write(tb)
    print("Traceback written to /tmp/task07_traceback.log")
