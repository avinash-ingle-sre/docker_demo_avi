#!/usr/bin/env python3
def parse_kv(line: str):
    if '=' not in line:
        raise ValueError("Missing '='")
    k,v = line.split('=',1)
    return {k.strip(): v.strip()}

if __name__ == "__main__":
    assert parse_kv("a=1") == {"a":"1"}
    try:
        parse_kv("badline")
    except ValueError:
        print("Test passed: invalid line raised ValueError")
    else:
        raise SystemExit("Test failed: invalid line did not raise")
    print("parse_kv tests ok")
