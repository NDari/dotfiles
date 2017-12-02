# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="modrobby"

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

# history options
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bundler
         docker
         docker-compose
         elixir
         git
         history-substring-search
         osx
         rake
         ruby
         tmux
         vim)

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
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$GOROOT/bin:$PATH

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"

# Rust stuff
export PATH="$HOME/.cargo/bin:$PATH"
# for racer to work. Must get rust source with "rustup component add rust-src"
export RUST_SRC_PATH=`rustc --print sysroot`/lib/rustlib/src/rust/src

# set editor stuff
export EDITOR=`which nvim`
alias e='nvim'

# system aliases
# alias python='python3'
alias gpo='gp --set-upstream origin `git_current_branch`'
alias c='clear'
alias enw='emacs -nw'
alias less='less -R' # pass escape chars through
alias tns='tmux new-session -s'

# pip rg to less. -ip => case-insensitive, colored
s() {
        rg -ip "$1" | less
}

t() {
        tree -Caf -L ${1:-1} | less
}

alias h='history | fzf'
alias ip='ipython'

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
# export rw=$HOME/Projects/red-wing
# export rwa=$rw/api
# export rwc=$rwa/core
# export rwv=$rwa/voucher
# export rwt=$rwa/trx
# export uat1="nadari@opwcs11.multiservice.com"
# export uat2="nadari@opwcs12.multiservice.com"
# export prod1="nadari@opwcs21.multiservice.com"
# export prod2="nadari@opwcs22.multiservice.com"
# export opdev="nadari@opdev04.multiservice.com"
# alias bundle='bundle _1.10.5_'
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/opt/oracle/instantclient_12_1
# export ORACLE_HOME=/opt/oracle/instantclient_12_1

# cambrian stuff
# export CB=$HOME/Projects/cambrian/common-core
# export CBPLATFORM="$CB/build-system/scripts/cb-environment.sh"
# export PATH=$CB/bin:$PATH
# export ANDROID_SDK=~/Library/Android/sdk
# export ANDROID_NDK=~/Library/Android/android-ndk-r15b
# export ANDROID_SDK_ROOT=$ANDROID_SDK
# export ANDROID_NDK_ROOT=$ANDROID_NDK
# export PATH=$PATH:$ANDROID_SDK/platform-tools
# export ANDROID_NDK_ARM=$ANDROID_NDK/toolchains/aarch64-linux-androideabi-4.9/prebuilt/darwin-x86_64
# export ANDROID_NDK_CLANG=$ANDROID_NDK/toolchains/llvm/prebuilt/darwin-x86_64

# pinsight stuff
export PATH=$PATH:$HOME/miniconda2/bin
export ds5="10.128.23.115"
export ds6="10.128.23.120"
export ds7="10.128.23.129"
export ds8="10.128.23.130"
export cl4="10.128.21.200"
# export SPARK_HOME=$HOME/tools/spark-2.2.0-bin-without-hadoop
# export HADOOP_CONF_DIR=/usr/hdp/2.6.1.0-129/hadoop/etc/hadoop/
# export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
# export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
# export PATH=$SPARK_HOME:$SPARK_HOME/bin:$PATH
# export SPARK_HOME="/usr/local/Cellar/apache-spark/2.2.0/libexec/"
# export PYTHONPATH=$SPARK_HOME/libexec/python/pyspark.zip:$PYTHONPATH
# export PYTHONPATH=$SPARK_HOME/libexec/python/lib/py4j-0.9-src.zip:$PYTHONPATH
export PYSPARK_DRIVER_PYTHON=ipython
export JAVA_HOME=$(/usr/libexec/java_home)

# cuda and cudann stuff
export CUDA_HOME="/usr/local/cuda"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export PATH="$CUDA_HOME/bin:$PATH"

# UMKC stuff
export lw='ndari@lewis4.rnet.missouri.edu'

# automatically add ssh agent on login.
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# fuzzy finder settings.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'
