#!/bin/bash

SLEEPING=$1 # 0 = no, 1 = yes

ROOTDIR=$(dirname "$0")
if [ "$ROOTDIR" = "." ]; then
    ROOTDIR=$(pwd)
fi
echo "1. ROOTDIR:$ROOTDIR"

sleeping () {
    echo "2. sleeping $SLEEPING"
    if [ "$SLEEPING." == "1." ]; then
        while true; do
            echo "Sleeping... forever."
            sleep 999999999
        done
    else
        echo "Cannot sleep must exit."
        exit 1
    fi
}

apt-get update -y && apt-get upgrade -y

export DEBIAN_FRONTEND=noninteractive

TZ=$(echo $TZ)

if [ "$TZ" = "" ]; then
    TZ=America/Denver
fi

export TZ=$TZ

ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt-get install -y tzdata

apt-get update -y
apt-get install net-tools -y
apt-get install iputils-ping -y
apt-get install nano -y

apt-get install -y apt-utils && apt-get install -y curl

apt-get update && apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    zsh \
    nano \
    htop \
    libssl-dev \
    wget 

curl -sL https://deb.nodesource.com/setup_16.x | bash -
apt-get install nodejs -y -q
npm install -g npm@8.1.3

apt-get update -y
apt-get upgrade -y
apt-get install software-properties-common -y
add-apt-repository ppa:git-core/ppa -y
apt-get update -y
apt-get install git -y --fix-missing
git config --global user.email "raychorn@gmail.com"
git config --global user.name "Ray C Horn" 

apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y --fix-missing
add-apt-repository ppa:deadsnakes/ppa -y
apt-get install python3.9 -y --fix-missing
apt-get install python3.9-dev -y --fix-missing
apt-get install python3.9-distutils -y --fix-missing
apt-get install python3.9-venv -y --fix-missing
curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python3.9 /tmp/get-pip.py
pip3.9 install --user --upgrade pip

yes | npm install -g @angular/cli

yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/powerline/fonts.git --depth=1

cd fonts
./install.sh

cd ..
rm -rf fonts

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k/powerlevel10k"/' "~/.zshrc"

nodejs --verrsion
npm --version
ng --version
python3.9 --version
pip3.9 --version
git --version

echo "Done prepping the container."
exit 0

while true; do
    sleep 10
done
