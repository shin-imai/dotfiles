FROM ubuntu:latest
WORKDIR /root
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
#ENV LC_ALL en_GB.UTF-8
RUN apt-get update && \
	apt-get install -y bash-completion neovim tmux git openssh-client curl locales
RUN sed -i '/en_GB.UTF-8/s/^# //g' /etc/locale.gen && \
	locale-gen && update-locale
RUN git clone https://github.com/shin-imai/dotfiles.git && cd dotfiles && \
	./.install_tools && cp -rp .bash* .kuberc .tmux.conf.local .vim /root && cd && rm -rf dotfiles
RUN apt-get clean

ENTRYPOINT ["/usr/bin/tmux"]
