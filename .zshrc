# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
         elixir
         docker-compose
         docker
         bundler
         rake
         ruby
         osx
         vim
         history-substring-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# vim mode
bindkey -v

export MANPATH="/usr/local/man:$MANPATH"

# manually set language environment
export LANG=en_US.UTF-8

# 10ms for key sequences
KEYTIMEOUT=1

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

#### Go stuff
export GOROOT=/usr/local/go
export GOPATH=$HOME/golib:$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$GOBIN:$GOROOT/bin:$PATH

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"

# Rust stuff
export PATH="$HOME/.cargo/bin:$PATH"
# for racer to work. Must get rust source with "rustup component add rust-src"
export RUST_SRC_PATH=`rustc --print sysroot`/lib/rustlib/src/rust/src

# set editor to neovim
export EDITOR=`which nvim`
alias e='nvim'
alias vim='e'
alias python='python3'
alias gpo='gp --set-upstream origin `git_current_branch`'
alias c='clear'
alias enw='emacs -nw'

DEFAULT_USER=`whoami`

# kotlin native
export PATH=$PATH:$HOME/src/kotlin-native/dist/bin

# MSTS stuff
export rw=$HOME/Projects/red-wing
export rwc=$rw/api/core
export rwv=$rw/api/voucher
export rwt=$rw/api/trx
export uat1="nadari@opwcs11.multiservice.com"
export uat2="nadari@opwcs12.multiservice.com"

# cambrian stuff
export CB=$HOME/Projects/cambrian/common-core
export CBPLATFORM="$CB/build-system/scripts/cb-environment.sh"
export PATH=$CB/bin:$PATH
export ANDROID_SDK=~/Library/Android/sdk
export ANDROID_NDK=~/Library/Android/android-ndk-r15b
export ANDROID_SDK_ROOT=$ANDROID_SDK
export ANDROID_NDK_ROOT=$ANDROID_NDK
export PATH=$PATH:$ANDROID_SDK/platform-tools
export ANDROID_NDK_ARM=$ANDROID_NDK/toolchains/aarch64-linux-androideabi-4.9/prebuilt/darwin-x86_64
export ANDROID_NDK_CLANG=$ANDROID_NDK/toolchains/llvm/prebuilt/darwin-x86_64

# automatically add ssh agent on login.
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi

# and kill it on logout
trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0
