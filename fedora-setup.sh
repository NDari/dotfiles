#!/usr/bin/env bash

sudo dnf install -y zsh

chsh -s /usr/bin/zsh

mkdir -p $HOME/.config

sudo dnf -y install ninja-build cmake gcc make gettext curl glibc-gconv-extra git
mkdir - $HOME/tools && cd $HOME/tools
git clone https://github.com/neovim/neovim.git
cd ./neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd $HOME

sudo dnf install -y fzf direnv

mkdir $HOME/.ssh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

