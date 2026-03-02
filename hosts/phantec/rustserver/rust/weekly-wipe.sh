#! /run/current-system/sw/bin/bash
set -euo pipefail

SERVER_CFG="/var/lib/rust/server/server/rustux/cfg/server.cfg"
SEEDS_FILE="/var/lib/rust/server/seeds.txt"

# Get current seed from server.cfg
CURRENT_SEED=$(grep '^server.seed ' "$SERVER_CFG" | awk '{print $2}')

echo "Current seed is: $CURRENT_SEED"

# Find the next line after the current seed in seeds.txt
NEXT_SEED=$(awk -v cur="$CURRENT_SEED" '
{
  if (found) { print; exit }
  if ($1 == cur) { found=1 }
}
' "$SEEDS_FILE")

echo "Next seed is: $NEXT_SEED"

# If current seed is last, loop to first
if [ -z "$NEXT_SEED" ]; then
  NEXT_SEED=$(head -n1 "$SEEDS_FILE")
fi

# Replace server.seed in server.cfg
sed -i "s/^server.seed .*/server.seed $NEXT_SEED/" "$SERVER_CFG"

# Restart Rust server with RCON
rcon-cli \
  --host 127.0.0.1 \
  --port 28016 \
  --password rustRconIljkqwhd6309qwdh9 \
  restart 300 \"Weekly wipe\"

