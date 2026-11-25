#!/usr/bin/env bash

set -xeuo pipefail

# Clone a repository, or update it if the target directory already holds one.
clone_or_pull() {
    local url=$1 dir=$2
    if [ -d "$dir/.git" ]; then
        git -C "$dir" pull --ff-only
    else
        git clone "$url" "$dir"
    fi
}

# Install or update zsh-autosuggestions and zsh-syntax-highlighting
mkdir -p ~/.zsh
clone_or_pull https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
clone_or_pull https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions

# Add the settings to ~/.zshrc unless they are already there.
# The check looks for a line that the earlier version of this script also wrote,
# so it recognises hosts where that version has already run.
if grep -qsF 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' ~/.zshrc; then
    echo "Skipping ~/.zshrc, settings already present"
else
    cat << 'EOF' >> ~/.zshrc
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt PROMPT_SUBST
PROMPT='%(?..%F{red}[%?]%f )%F{green}%n@%m%f:%F{blue}%~%(!.#.$) '

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
EOF
fi

# Install or update fzf
clone_or_pull https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
