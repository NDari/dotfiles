# put in .bash_profile
export PATH=$PATH:$HOME/local/bin
export SHELL=`which zsh`
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
