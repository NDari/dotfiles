#!/usr/bin/env bash

set -eu pipefail

cd $HOME

sudo dnf install -y zsh

chsh -s /usr/bin/zsh

mkdir -p $HOME/.config

# git
sudo dnf install -y git
git config --global user.email "naseerdari01@gmail.com"
git config --global user.name "Naseer Dari"
git config --global init.defaultbranch "main"
git config --global core.whitespace "cr-at-eol"


sudo dnf install -y ninja-build cmake gcc make gettext curl glibc-gconv-extra git
mkdir - $HOME/tools && cd $HOME/tools
git clone https://github.com/neovim/neovim.git
cd ./neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd $HOME

sudo dnf install -y fzf direnv

mkdir $HOME/.ssh

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# post download of this repo
cd $HOME
mkdir -p $HOME/.config/zsh
ln -s $DOTFILES/zsh/zshrc $HOME/.config/zsh/.zshrc
ln -s $DOTFILES/zsh/zshenv $HOME/.zshenv

mkdir -p $HOME/.config/nvim
ln -s $DOTFILES/nvim/init.lua $HOME/.config/nvim/init.lua

# oh my posh
curl -s https://ohmyposh.dev/install.sh | bash -s
