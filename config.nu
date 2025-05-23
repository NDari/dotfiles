# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# carapace, keep at top?
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# need this for windows terminal for some reason
$env.config.shell_integration.osc133 = false

$env.config.buffer_editor = "nvim"

# plugin dir.
const NU_PLUGIN_DIRS = [
	($nu.current-exe | path dirname)
	... $NU_PLUGIN_DIRS
]

# aliases
alias e = nvim
alias c = clear
alias tns = tmux new-session -s
alias tl = tmux list-sessions
alias ta = tmux attach -t

# carapace
source ~/.cache/carapace/init.nu

# oh-my-posh
source ~/.config/oh-my-posh/.oh-my-posh.nu
