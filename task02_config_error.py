#!/usr/bin/env python3
import json
class ConfigError(Exception): pass
try:
    with open('/tmp/nonexistent_config.json', 'r') as f:
        json.load(f)
except (FileNotFoundError, json.JSONDecodeError) as e:
    raise ConfigError("Config load failed") from e
