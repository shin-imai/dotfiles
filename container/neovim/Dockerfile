FROM alpine:edge

ENV TZ=Europe/London
ENV LANG=en_GB.UTF-8
ENV TERM=xterm-256color

RUN apk add zsh zsh-vcs gzip tmux tzdata yarn git lazygit python3 py-pip pipx go fzf fd fx lf jq yq bat eza kubectl helm cargo neovim ripgrep alpine-sdk curl --update

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
