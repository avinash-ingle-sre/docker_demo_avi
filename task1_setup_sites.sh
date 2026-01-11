#!/bin/bash
# Task 1: setup simulated site directories and config
DR_DIR="/tmp/dr_lab"
SITES_DIR="$DR_DIR/sites"
CONFIG_FILE="$DR_DIR/dr_config.json"

mkdir -p "$SITES_DIR/primary/data" "$SITES_DIR/secondary/data"
cat > "$SITES_DIR/primary/data/app_data.txt" <<DATA
Primary site sample data
User: alice
User: bob
DATA

cat > "$CONFIG_FILE" <<JSON
{
  "primary": {"name":"primary","endpoint":"https://primary.example.local"},
  "secondary": {"name":"secondary","endpoint":"https://secondary.example.local"},
  "rto_minutes": 15,
  "rpo_minutes": 5,
  "auto_failover": true
}
JSON

echo "Setup complete:"
ls -R "$DR_DIR"
