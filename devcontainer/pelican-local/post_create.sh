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
  rm -rf ~/."$f"
  ln -sf "$P"/"$f" ~/."$f"
done

# Install Claude Code CLI and OpenCode
curl -fsSL https://claude.ai/install.sh | bash
curl -fsSL https://opencode.ai/v2/install | bash
mkdir -p ~/.config/opencode
ln -sf "$P"/opencode/config/opencode.json ~/.config/opencode/opencode.json
ln -sf "$P"/opencode/config/service.json ~/.config/opencode/service.json
mkdir -p ~/.local/share/opencode
ln -sf "$P"/opencode/data/opencode.db ~/.local/share/opencode/opencode.db
