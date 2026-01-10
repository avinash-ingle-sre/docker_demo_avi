#!/usr/bin/env python3
# To debug: python3 -m pdb /tmp/task08_debug_instructions.py
def compute(a,b):
    res = a+b
    res *= 2
    return res

if __name__ == "__main__":
    print("Compute result:", compute(2,3))
    # set a breakpoint on the line above when running with pdb
