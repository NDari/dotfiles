#  ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
*) return;;
esac

#### History section

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Combine multiline commands into one in history
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# Add time stamps to history
HISTTIMEFORMAT='%F %T '

# record history right away, not when session terminates
PROMPT_COMMAND='history -a'

################################################################################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# set default editor to vim
export EDITOR="/usr/local/bin/vim"

#### Aliases

# some more ls aliases
alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='ls -d */'

# some cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias python='python3'
alias c='clear'
alias t='tree -C'
alias t1='tree -L 1 -C'
alias t2='tree -L 2 -C'
alias v='vim'
alias snig='sudo npm install -g'
alias m='micro'
alias ps='ps f' # f for forest: this shows tree view

# apt-get aliases
alias sagi='sudo apt-get install'
alias sagu='sudo apt-get update'
alias saguu='sudo apt-get update && sudo apt-get upgrade'
alias ac='apt-cache'

# ember aliases
alias e='ember'
alias egr='ember generate route'
alias egt='ember generate template'
alias egm='ember generate model'
alias egc='ember generate component'
alias ega='ember generate adapter'
alias egs='ember generate serializer'
alias egres='ember generate resource'
alias egh='ember generate helper'
alias egb='ember generate blueprint'

# git aliases
alias gsu='git submodule update --init --recursive'
alias gits='git status'
alias gitc='git commit'

# random command shortcuts
alias cl='clear'

. ~/.git-completion.bash

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export GIT_PS1_SHOWDIRTYSTATE=1

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

################################################################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi


#### Go stuff

export GOROOT=/usr/local/go
export GOPATH=$HOME/golib:$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$GOBIN:$GOROOT/bin:$PATH

#### Rust stuff

export CARGO_HOME=$PATH:$HOME/.cargo
export PATH=$PATH:$CARGO_HOME/bin
export RUST_SRC_PATH=/usr/local/src/rustc-1.9.0/src # had to manually install this

################################################################################



RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
LIGHTGRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"
NO_COLOR="\[\033[0m\]"

PS1="[ $LIGHTGRAY\w$YELLOW\$(__git_ps1)$NO_COLOR ]\n\$ "


bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Add the user's bin to the path
export PATH=$HOME/bin:$PATH


# MSTS stuff
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
#export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export ATOM_NODE_URL=http://gh-contractor-zcbenz.s3.amazonaws.com/atom-shell/dist
export ORACLE_HOME=/usr/lib/oracle/12.1/client64
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
OP4='nadari@opdev04.dev.multiservice.com'
Beta='nadari@cn-app.dev.infolock.com'
export PATH="$HOME/bin":$PATH

# correct coloring of the terminal
#export TERM=xterm-256color

# color for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;0;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# let git skip ssl
export GIT_SSL_NO_VERIFY=1

# Cambrian stuff
#export ANDROID_HOME=/Users/naseer/Library/Android/sdk
#export NDK_ROOT=/Users/naseer/Library/Android/android-ndk-r12b
#export ANDROID_NDK=/Users/naseer/Library/Android/android-ndk-r12b
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home
#export CB=/Users/naseer/Projects/CambrianTech/common-core
#export CBPLATFORM="osx"
#source $CB/build-system/scripts/cb-environment.sh
#export AWS_ACCESS_KEY_ID='AKIAIIU4JWU5RXP6XW5Q'
#export AWS_SECRET_ACCESS_KEY='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'
#export HH_PORT=5000
#export HH_FACEBOOK_APP_ID='431575490384800'
#export HH_FACEBOOK_SECRET='e6a1b9528093f31f423301de81ba576a'
#export HH_LICENSE_KEY='DEMO'
#export HH_PROJECT_DIRECTORY='public/projects'
#export HH_IMAGE_UPLOAD_DIRECTORY='public/image_uploads'
#export HH_S3_PROJECTS_BUCKET='home-harmony-projects'

# cuda and cudann stuff
export CUDA_HOME="/usr/local/cuda"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export PATH="$CUDA_HOME/bin:$PATH"

# bash_it
source $HOME/.bash_profile


# added by Anaconda3 4.3.1 installer
export PATH="/Users/naseer/anaconda/bin:$PATH"

# added by Anaconda3 4.4.0 installer
export PATH="/Users/naseer/anaconda/bin:$PATH"
