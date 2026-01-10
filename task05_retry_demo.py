#!/usr/bin/env python3
import random, time
def retry(max_attempts=3, delay=0.5):
    def dec(f):
        def w(*a, **k):
            attempts=0
            while attempts < max_attempts:
                try:
                    return f(*a, **k)
                except Exception as e:
                    attempts+=1
                    print(f"attempt {attempts} failed: {e}")
                    if attempts>=max_attempts:
                        raise
                    time.sleep(delay)
        return w
    return dec

@retry(4, 0.2)
def flaky():
    if random.random() < 0.7:
        raise RuntimeError("transient")
    return "ok"

try:
    print("flaky ->", flaky())
except Exception as e:
    print("flaky failed after retries:", e)
