#!/usr/bin/env bash

set -eux

P="$HOME/.persist"

# Create symlinks for files/folders that need to be persistent
files=( zsh_history gitconfig )
for f in ${files[@]}; do
  touch "$P"/"$f"
  ln -sf "$P"/"$f" ~/."$f"
done

folders=( claude )
for f in ${folders[@]}; do
  mkdir -p "$P"/"$f"
  ln -sf "$P"/"$f" ~/."$f"
done

# Install Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash
