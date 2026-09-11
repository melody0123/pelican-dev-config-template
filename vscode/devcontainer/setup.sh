#!/usr/bin/env bash
set -e
go install github.com/go-delve/delve/cmd/dlv@latest

sudo dnf install -y fzf zsh-autosuggestions zsh-syntax-highlighting

cat >> ~/.zshrc <<'EOF'
source /usr/share/fzf/shell/key-bindings.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%F{red}%b%f)'
zstyle ':vcs_info:git:*' actionformats ' (%F{red}%b|%a%f)'
setopt PROMPT_SUBST
PROMPT='%(?..%F{red}[%?]%f )%F{green}%n%f ➜ %F{blue}%~%f${vcs_info_msg_0_} '

alias ls='ls --color=auto'
alias ll='ls -al'
EOF

sudo usermod -s /usr/bin/zsh vscode

sudo chown vscode:vscode -R /home/vscode/.claude
curl -fsSL https://claude.ai/install.sh | bash