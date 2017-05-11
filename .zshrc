# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

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
export HISTFILE="$HOME/.zhistory"
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTTIMEFORMAT="[%F %T] "

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# For autosuggestions: git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
plugins=(
  #bundler
  git
  history-substring-search
  #ubuntu
  #archlinux
  #kubectl
  fzf
  #rails
)

source $ZSH/oh-my-zsh.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

# remove the random A and B or [OA that appear sometimes
printf "\e[?1004l"

# manually set language environment
export LANG=en_US.UTF-8

# set editor stuff
export EDITOR=`which nvim`

# make ctrlp/n work with partially types commands
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# system aliases
alias gpo='gp --set-upstream origin `git_current_branch`'
alias c='clear'
alias enw='emacs -nw'
alias e='nvim'
alias less='less -R' # pass escape chars through
alias tns='tmux new-session -s'
alias tl='tmux list-sessions'
alias ta='tmux attach -t'
alias h='history | fzf'
alias ip='ipython'
alias ips='ipython --profile slime'
alias vi="nvi"
alias pyspark='PYSPARK_DRIVER_PYTHON=ipython pyspark'
alias ls='ls --color=always'

# kubernetes
alias kp='kgp' # requires kubernetes plugin
alias kt='kubetail' # brew tap johanhaleby/kubetail && brew install kubetail
alias kc="kubectx" # brew install kubectx
kcon() {
  keti $1 -- /bin/bash
}

# color for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;0;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

DEFAULT_USER=`whoami`

# remove things like ^M on enter for interactive CLIs
stty sane

# ssh
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
  (umask 077; ssh-agent >| "$env")
  . "$env" >| /dev/null ;
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
  agent_start
  ssh-add -k
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
  ssh-add -k
fi
unset env

# fuzzy finder settings.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" -u --ignore-vcs'

declare -a zshrc_files=(
".zshrc-msts"
".zshrc-personal"
".zshrc-tc"
".zshrc-personal-linux"
".zshrc-personal-wsl"
)

# source all the special files if they exist.
for f in "${zshrc_files[@]}"
do
  if [ -L "${HOME}/${f}" ]; then
    echo "loading $HOME/$f"
    source "${HOME}/${f}"
  fi
done

# source custom shell functions
source $HOME/dotfiles/shell-functions

# make direnv work, and work with tmux
if which direnv > /dev/null; then
  if [[ -n $TMUX && -n $DIRENV_DIR ]]; then
      unset `printf '%s ' ${(kM)parameters:#DIRENV_*}`  # unset env vars starting with DIRENV_
  fi
  eval "$(direnv hook zsh)"
fi
