FROM mashmb/nvim-go:dev
RUN apt-get update && \
	apt-get install -y tmux openssh-client locales
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
	locale-gen && update-locale
RUN git clone https://github.com/shin-imai/dotfiles.git && cd dotfiles && \
	./.install_tools && cp -rp .bash* .kuberc .tmux.conf.local /root && cd - && rm -rf dotfiles
RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-20.10.16.tgz | \
  tar zx --strip-components 1 -C /usr/local/bin docker/docker
RUN apt-get clean
