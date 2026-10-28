#!/usr/bin/env bash
# Runs on the host before each build (initializeCommand).
# Fails the build if our Dockerfile's base image drifted from the tracked devcontainer.json.

set -eu

ours=$(sed -n 's/^FROM //p' .devcontainer/local/Dockerfile)
upstream=$(sed -n 's/.*"image": *"\(.*\)".*/\1/p' .devcontainer/devcontainer.json)

if [ "$ours" != "$upstream" ]; then
  echo "Base image drift:"
  echo "  .devcontainer/local/Dockerfile:   $ours"
  echo "  .devcontainer/devcontainer.json:  $upstream"
  echo "Update the FROM line, then rebuild."
  exit 1
fi
