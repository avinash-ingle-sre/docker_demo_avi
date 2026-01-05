#!/usr/bin/env python3
import shutil
import random

CPU_THRESHOLD = 80.0
MEM_THRESHOLD = 85.0
DISK_THRESHOLD = 90.0

def check_disk_usage(path="/"):
    total, used, free = shutil.disk_usage(path)
    return (used / total) * 100

def check_cpu_usage():
    # Simulate high CPU for testing
    return random.uniform(75.0, 95.0)

def check_memory_usage():
    return random.uniform(60.0, 90.0)

def main():
    print("--- Running System Health Check ---")
    
    cpu = check_cpu_usage()
    mem = check_memory_usage()
    disk = check_disk_usage()

    print(f"CPU: {cpu:.2f}% | Memory: {mem:.2f}% | Disk: {disk:.2f}%")

    if cpu > CPU_THRESHOLD:
        print(f"ALERT: High CPU usage detected: {cpu:.2f}%")
    
    if mem > MEM_THRESHOLD:
        print(f"ALERT: High Memory usage detected: {mem:.2f}%")

    if disk > DISK_THRESHOLD:
        print(f"ALERT: Low Disk space detected: {disk:.2f}% used")

    print("--- Check Complete ---")

if __name__ == "__main__":
    main()
