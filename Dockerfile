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
########### BEGIN
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update -y && \
    apt-get install git -y --fix-missing && \
    git config --global user.email "raychorn@gmail.com" && \
    git config --global user.name "Ray C Horn" 
############## END
RUN apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y --fix-missing && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install python3.9 -y --fix-missing && \
    apt-get install python3.9-dev -y --fix-missing && \
    apt-get install python3.9-distutils -y --fix-missing && \
    apt-get install python3.9-venv -y --fix-missing && \
    curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
    python3.9 /tmp/get-pip.py && \
    pip3.9 install --user --upgrade pip

#####################################################################################################
RUN apt-get install aptitude -y --fix-missing && \
    aptitude install libnode-dev -y && \
    aptitude install libnode64 -y && \
    aptitude install node-gyp -y && \
    aptitude install npm -y

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install nodejs -y -q && \
    npm install -g npm@8.1.3

RUN yes | npm install -g @angular/cli
    #npm install -g npm-check-updates && \
    #npm i -g npm-upgrade

RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
