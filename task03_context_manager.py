#!/usr/bin/env python3
from contextlib import contextmanager
@contextmanager
def demo(name):
    print("acquire", name)
    try:
        yield
    finally:
        print("release", name)
# demonstrate
with demo("resource-1"):
    print("using resource")
    # uncomment to test exception handling
    # raise RuntimeError("simulated")
