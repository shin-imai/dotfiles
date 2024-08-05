FROM alpine:edge

ENV TZ=Europe/London
ENV LANG=en_GB.UTF-8
ENV TERM=xterm-256color
ENV LV_BRANCH=release-1.4/neovim-0.9

RUN apk add zsh zsh-vcs gzip tzdata yarn git lazygit python3 py-pip pipx go fzf fd jq yq bat eza kubectl helm cargo neovim ripgrep alpine-sdk curl --update && \
      addgroup -S lunaruser && adduser -S lunaruser -G lunaruser --shell /bin/zsh && \
      su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.4/neovim-0.9/utils/installer/install.sh) --no-install-dependencies" lunaruser

USER lunaruser

RUN curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh |sh -s && \
      git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && \
      sed -i 's#^ZSH_THEME=.*#ZSH_THEME="powerlevel10k/powerlevel10k"#' ~/.zshrc  && \
      sed -i 's#^plugins=(\(.*\))#plugins=(\1 zsh-autosuggestions kubectl vi-mode web-search)#' ~/.zshrc && \
      mkdir -p ~/.config/zsh

RUN curl https://raw.githubusercontent.com/shin-imai/dotfiles/master/mac/9_bat_themes.sh | sh -s && \
      curl https://raw.githubusercontent.com/shin-imai/dotfiles/master/mac/4_custom.sh | sh -s && \
      curl https://raw.githubusercontent.com/shin-imai/dotfiles/master/mac/7_git_setup.sh | sh -s

RUN rm -f /home/lunaruser/.config/lvim/* && git clone https://github.com/shin-imai/lvim-config.git /home/lunaruser/.config/lvim && \
      mkdir -p /home/lunaruser/workspace && \
      go install github.com/charmbracelet/glow@latest && \
      helm plugin install https://github.com/databus23/helm-diff && \
      helm plugin install https://github.com/jkroepke/helm-secrets

RUN pipx install pre-commit

ENTRYPOINT [ "/bin/zsh" ]
WORKDIR /home/lunaruser/workspace
