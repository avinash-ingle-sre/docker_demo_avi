#!/usr/bin/env python3
# Python Error Handling & Debugging Demo
# Demonstrates try/except, custom exceptions, context managers, logging, assertions,
# retries, pdb usage (illustrative), traceback inspection, and unit-testable functions.

import logging
import json
import time
import random
import traceback
from contextlib import contextmanager

LOG_FILE = "/tmp/python_error_handling_demo.log"

# Configure logging
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(message)s",
)

# Custom exception
class ConfigError(Exception):
    pass

# Context manager example (resource simulation)
@contextmanager
def managed_resource(name):
    logging.info(f"Acquiring resource: {name}")
    print(f"Acquiring resource: {name}")
    try:
        yield {"name": name, "created_at": time.time()}
    finally:
        logging.info(f"Releasing resource: {name}")
        print(f"Releasing resource: {name}")

# Retry decorator (simple)
def retry(max_attempts=3, delay=1):
    def decorator(fn):
        def wrapper(*args, **kwargs):
            attempts = 0
            while attempts < max_attempts:
                try:
                    return fn(*args, **kwargs)
                except Exception as e:
                    attempts += 1
                    logging.warning(f"Attempt {attempts}/{max_attempts} failed: {e}")
                    if attempts >= max_attempts:
                        logging.error(f"All {max_attempts} attempts failed for {fn.__name__}")
                        raise
                    time.sleep(delay)
        return wrapper
    return decorator

# Functions to demonstrate various error handling patterns

def load_config(path):
    """Load JSON config and validate required fields. Raises ConfigError on invalid config."""
    try:
        with open(path, 'r', encoding='utf-8') as f:
            cfg = json.load(f)
    except FileNotFoundError:
        logging.exception("Config file not found")
        raise ConfigError(f"Config file missing: {path}")
    except json.JSONDecodeError:
        logging.exception("Invalid JSON in config")
        raise ConfigError(f"Invalid JSON in config: {path}")

    # Basic validation
    if 'service' not in cfg or 'port' not in cfg:
        logging.error("Config validation failed: missing required keys")
        raise ConfigError("Config missing required keys: 'service' and 'port'")
    return cfg

def divide(a, b):
    """Simple division with explicit error handling for ZeroDivisionError."""
    try:
        return a / b
    except ZeroDivisionError as e:
        logging.error("Division by zero attempted", exc_info=True)
        raise

def safe_int(s):
    """Convert to int, raise ValueError if conversion fails (demonstrates chaining)."""
    try:
        return int(s)
    except Exception as e:
        logging.debug("Failed to convert to int", exc_info=True)
        raise ValueError(f"Invalid integer value: {s}") from e

@retry(max_attempts=4, delay=0.5)
def flaky_operation(threshold=0.7):
    """Operation that fails randomly to demonstrate retries."""
    val = random.random()
    logging.debug(f"flaky_operation generated {val:.3f}")
    if val < threshold:
        raise RuntimeError(f"Transient failure (val={val:.3f})")
    return f"Success with {val:.3f}"

def demonstrate_assertions():
    x = 5
    assert x == 5, "x must be 5"
    try:
        assert x == 10, "intentional assertion failure"
    except AssertionError as e:
        logging.warning("Assertion caught in demonstration: %s", e)

def show_traceback_demo():
    try:
        # nested error to show full traceback
        def inner():
            raise ValueError("Inner error for traceback demo")
        def outer():
            inner()
        outer()
    except Exception as e:
        tb = traceback.format_exc()
        print("Captured traceback (short):")
        print(tb.splitlines()[-3:])
        logging.error("Captured traceback for analysis:\n%s", tb)

# Simple unit-testable helper
def parse_key_value_line(line: str) -> dict:
    """Parses 'key=value' lines, raises ValueError on malformed input."""
    if '=' not in line:
        raise ValueError("Line missing '=' separator")
    k, v = line.split('=', 1)
    return {k.strip(): v.strip()}

def interactive_debug_demo():
    # This function is intentionally interactive if run manually.
    # For automated labs we just print a hint how to run pdb manually.
    print("To debug interactively: run 'python3 -m pdb /tmp/task_debug_demo.py' and set breakpoints.")
    logging.info("Interactive debug demo: instruct user to run with pdb")

def main_demo():
    print("Python Error Handling & Debugging Demo")
    logging.info("Demo started")

    # Context manager demo
    with managed_resource("demo-db") as r:
        print("Resource acquired:", r['name'])

    # Config load demo (expected to fail if file missing)
    try:
        cfg = load_config("/tmp/nonexistent_config.json")
        print("Loaded config:", cfg)
    except ConfigError as e:
        print("Config error caught as expected:", e)

    # Division demo
    try:
        print("10 / 2 =", divide(10, 2))
        print("10 / 0 -> should raise")
        divide(10, 0)
    except Exception as e:
        print("Division error caught:", e)

    # safe_int demo
    try:
        print("safe_int('42') ->", safe_int("42"))
        print("safe_int('abc') -> should raise")
        safe_int("abc")
    except ValueError as e:
        print("Conversion error caught:", e)

    # Retry/flaky demo
    try:
        res = flaky_operation(threshold=0.9)  # make it likely to retry
        print("Flaky operation result:", res)
    except Exception as e:
        print("Flaky operation failed after retries:", e)

    # Assertions and traceback demo
    demonstrate_assertions()
    show_traceback_demo()

    # parse helper demo
    try:
        print("parse_key_value_line('a=1') ->", parse_key_value_line("a=1"))
        print("parse_key_value_line('bad-line') -> should raise")
        parse_key_value_line("bad-line")
    except ValueError as e:
        print("Parsing error caught:", e)

    print("Demo complete. Check log at", LOG_FILE)
    logging.info("Demo finished")

if __name__ == "__main__":
    main_demo()

