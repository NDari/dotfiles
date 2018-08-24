#!/bin/sh

# Modified version of thoughtbots script
# https://github.com/thoughtbot/laptop/blob/master/mac

fancy_echo() {
  local fmt="$1"; shift

  printf "\n$fmt\n" "$@"
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/bin/" ]; then
  mkdir "$HOME/bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

fancy_echo "Installing brew packages"
brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle --file=$HOME/dotfiles/Brewfile

update_shell() {
  local shell_path;
  shell_path="$(which zsh)"

  fancy_echo "Changing your shell to zsh ..."
  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    fancy_echo "Adding '$shell_path' to /etc/shells"
    sudo sh -c "echo $shell_path >> /etc/shells"
  fi
  sudo chsh -s "$shell_path" "$USER"
}

case "$SHELL" in
  */zsh)
    if [ "$(which zsh)" != '/usr/local/bin/zsh' ] ; then
      update_shell
    fi
    ;;
  *)
    update_shell
    ;;
esac

cd $HOME

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

if [ ! -d ".config/nvim" ]; then
  mkdir -p ".config/nvim"
fi

ln -s dotfiles/.ctags
ln -s dotfiles/.tmux.conf
ln -s dotfiles/.zshrc
ln -s dotfiles/.zlogout
ln -s dotfiles/.inputrc
cd .config/nvim
ln -s ~/dotfiles/init.vim .
