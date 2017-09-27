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
# ENABLE_CORRECTION="true"

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

export MANPATH="/usr/local/man:$MANPATH"

# manually set language environment
export LANG=en_US.UTF-8

# 10ms for key sequences
KEYTIMEOUT=1

# do not save duplicate commands in history
export HISTCONTROL=ignoreboth:erasedups

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

# system aliases
alias python='python3'
alias gpo='gp --set-upstream origin `git_current_branch`'
alias c='clear'
alias t='tree -C'
alias t1='tree -L 1 -C'
alias t2='tree -L 2 -C'
alias enw='emacs -nw'
alias less='less -R' # pass escape chars through

# color for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;0;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


DEFAULT_USER=`whoami`

# kotlin native
export PATH=$PATH:$HOME/src/kotlin-native/dist/bin

# MSTS stuff
export rw=$HOME/Projects/red-wing
export rwa=$rw/api
export rwc=$rwa/core
export rwv=$rwa/voucher
export rwt=$rwa/trx
export uat1="nadari@opwcs11.multiservice.com"
export uat2="nadari@opwcs12.multiservice.com"
export prod1="nadari@opwcs21.multiservice.com"
export prod2="nadari@opwcs22.multiservice.com"
export opdev="nadari@opdev04.multiservice.com"
alias bundle='bundle _1.10.5_'
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/opt/oracle/instantclient_12_1
export ORACLE_HOME=/opt/oracle/instantclient_12_1

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

# cuda and cudann stuff
export CUDA_HOME="/usr/local/cuda"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export PATH="$CUDA_HOME/bin:$PATH"

# UMKC stuff
export lw='ndari@lewis4.rnet.missouri.edu'

# automatically add ssh agent on login.
if [ -z "$SSH_AUTH_SOCK" ] ; then
  echo "Found ssh socket file"
  eval `ssh-agent -s`
  ssh-add
fi

# fuzzy finder settings.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# make ripgrep the default searcher for fzf
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
