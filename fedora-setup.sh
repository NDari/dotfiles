#!/usr/bin/env bash

set -eu pipefail

cd $HOME

# git
sudo dnf install -y git

git clone https://github.com/NDari/new-dots.git $HOME/dotfiles

# git conf
git config --global user.email "naseerdari01@gmail.com"
git config --global user.name "Naseer Dari"
git config --global init.defaultbranch "main"
git config --global core.whitespace "cr-at-eol"
git config --global include.path $HOME/dotfiles/delta/delta.conf

# zsh
cd $HOME
sudo dnf install -y zsh
chsh -s /usr/bin/zsh
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc

# oh my posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# zinit
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# nvim
cd $HOME
mkdir -p $HOME/.config/nvim
ln -s $HOME/dotfiles/nvim/init.lua $HOME/.config/nvim/init.lua

mkdir $HOME/.ssh

sudo dnf install -y \
	fzf \
	neovim \
	direnv \
	tmux \
	xclip \
	tldr \
	openssl-devel \
	uv

# tmux
cd $HOME
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf
$HOME/.tmux/plugins/tpm/bin/install_plugins

# go
mkdir -p $HOME/tools && cd $HOME/tools
curl -LO https://go.dev/dl/go1.24.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz
rm go1.24.3.linux-amd64.tar.gz
cd $HOME

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
$HOME/.cargo/bin/cargo install cargo-update
$HOME/.cargo/bin/cargo install du-dust
$HOME/.cargo/bin/cargo install git-delta
$HOME/.cargo/bin/cargo install just
$HOME/.cargo/bin/cargo install fd-find
$HOME/.cargo/bin/cargo install ripgrep
$HOME/.cargo/bin/cargo install bat
$HOME/.cargo/bin/cargo install zoxide
$HOME/.cargo/bin/cargo install procs
