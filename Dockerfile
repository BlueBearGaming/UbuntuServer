FROM ubuntu:xenial

RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime

ENV SSH_AUTH_SOCK /ssh-agent
ENV DEBIAN_FRONTEND noninteractive
ENV WWW_HOME /var/www

# Update APT and install base packages
RUN apt-get clean && \
    apt-get update && \
    apt-get -y dist-upgrade \
    apt-get install -y \
    nano \
    curl \
    git \
    wget \
    sudo \
    zsh \
    locales \
    apt-utils \
    software-properties-common \
    pv \
    inetutils-ping

# Rebuild locales properly
RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Make default unix user id match www-data
RUN usermod -u 1000 www-data
# Allow shell access for www-data
RUN chsh -s /bin/zsh www-data
# Make www-data sudoer (without password)
RUN echo "www-data ALL=NOPASSWD: ALL" | (EDITOR="tee -a" visudo)
# Create home directory and set proper permissions
RUN mkdir -p $WWW_HOME
RUN chown www-data:1000 $WWW_HOME

USER www-data
RUN git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $WWW_HOME/.oh-my-zsh
COPY zshrc $WWW_HOME/.zshrc
