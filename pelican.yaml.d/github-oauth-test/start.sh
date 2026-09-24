#!/bin/bash
# Start director, registry, origin and cache as four separate pelican-server
# processes. Each one gets its own ConfigBase, RuntimeDir and data directory
# under srv/<component>/ so nothing on disk is shared between them except the
# origin's export directory (srv/export), which is shared on purpose.
set -xeuo pipefail
cd "$(dirname "$0")"

BIN=../dist/pelican-server_linux_arm64_v8.0/pelican-server

for svc in director registry origin cache; do
  mkdir -p "srv/$svc/config" "srv/$svc/run" "srv/$svc/data"
done
mkdir -p srv/export

nohup "$BIN" director serve --config director.yaml > director.log 2>&1 &
sleep 10
nohup "$BIN" registry serve --config registry.yaml > registry.log 2>&1 &
sleep 10
nohup "$BIN" origin   serve --config origin.yaml   > origin.log   2>&1 &
sleep 10
nohup "$BIN" cache    serve --config cache.yaml    > cache.log    2>&1 &
