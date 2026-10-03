#!/usr/bin/env bash

# Create symlinks for files/folders that need to be persistent
dst=(claude zsh_history gitconfig)
for d in ${dst[@]}; do
  rm -rf ~/."$d"
  ln -sf ~/.persist/"$d" ~/."$d"
done

# Install Claude Code CLI first in case it overwrites ~/.claude 
curl -fsSL https://claude.ai/install.sh | bash
