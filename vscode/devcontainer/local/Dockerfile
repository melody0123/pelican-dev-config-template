FROM hub.opensciencegrid.org/pelican_platform/pelican-dev:latest-itb

# Shell tooling (was installed via sudo in setup.sh)
RUN dnf install -y fzf zsh zsh-autosuggestions zsh-syntax-highlighting \
 && dnf clean all

# Non-root user at uid 1000 with zsh as login shell
# (replaces the common-utils feature and the sudo usermod)
ARG USERNAME=vscode
ARG UID=1000
RUN groupadd -g ${UID} ${USERNAME} \
 && useradd -m -u ${UID} -g ${UID} -s /usr/bin/zsh ${USERNAME} \
 && mkdir -p /home/${USERNAME}/go /home/${USERNAME}/.claude /home/${USERNAME}/.local/bin \
 && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
ENV GOPATH=/home/${USERNAME}/go \
    PATH=/usr/local/go/bin:/home/${USERNAME}/go/bin:/home/${USERNAME}/.local/bin:${PATH}

# Go debugger (was the team's postCreateCommand)
RUN go install github.com/go-delve/delve/cmd/dlv@latest

COPY --chown=${USERNAME}:${USERNAME} zshrc /home/${USERNAME}/.zshrc
WORKDIR /workspaces/pelican
