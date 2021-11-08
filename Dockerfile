# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

LABEL version="1.0"
LABEL maintaner="Ray C Horn (raychorn@gmail.com)"
LABEL release-date="11-08-2021"
LABEL promoted="true"

RUN apt-get update -y && \
    apt-get install curl -y --fix-missing && \
    apt-get install build-essential libssl-dev -y --fix-missing

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    zsh \
    nano \
    htop \
    libssl-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN TZ=US/Mountain \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
########### BEGIN
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get install nodejs -y -q --fix-missing
############## END
##############################################################################################
RUN yes | npm install -g @angular/cli && \
    ng version && \
    apt-get upgrade git -y --fix-missing && \
    apt install default-jre -y --fix-missing && \
    apt install openjdk-11-jre-headless -y --fix-missing && \
    apt install openjdk-8-jre-headless -y --fix-missing 
########### BEGIN
RUN apt install libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc -y && \
    cd /tmp && \
    curl -o git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.29.2.tar.gz && \
    tar -zxf git.tar.gz && \
    cd git-* && \
    make prefix=/usr/local all && \
    make prefix=/usr/local install && \
    git config --global user.email "raychorn@gmail.com" && \
    git config --global user.name "Ray C Horn" 
############### OR NEW
RUN apt update -y && \
    apt-get upgrade -y && \
    apt install make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip -y --fix-missing && \
    cd /tmp && \
    curl -o git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.29.2.tar.gz && \
    tar -zxf git.tar.gz && \
    cd git-* && \
    NPROC=$(nproc) && \
    make -j $NPROC && \
    make prefix=/usr/local all && \
    make prefix=/usr/local install && \
    git config --global user.email "raychorn@gmail.com" && \
    git config --global user.name "Ray C Horn" 
############## END
RUN npm install -g npm-check-updates
#########################################################################################################
RUN apt install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y --fix-missing && \
    apt install software-properties-common -y && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt install python3.9 -y --fix-missing && \
    python3.9 -m ensurepip --upgrade && \
    pip install virtualenv

#####################################################################################################
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get install nodejs -y -q --fix-missing && \
    npm cache clean -f && \
    npm install -g n && \
    n latest && \
    npm install -g firebase-tools

RUN yes | npm install -g @angular/cli && \
    npm install -g npm-check-updates && \
    npm i -g npm-upgrade

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
