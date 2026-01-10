#!/usr/bin/env python3
def do_check(x):
    assert isinstance(x, int), "x must be int"
    assert x >= 0, "x must be non-negative"
    return x*2

try:
    print(do_check(3))
    print(do_check(-1))
except AssertionError as e:
    print("Assertion caught:", e)
