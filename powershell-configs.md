# install powershell 7 with winget

This installs to $Env:ProgramFiles\PowerShell\7

- winget install --id Microsoft.PowerShell --source winget

# install the readline module

- Install-Module -Name PSReadLine -AllowClobber -Force

# change the terminal keybindings to match emacs

- Set-PSReadLineOption -EditMode Emacs

# stop the annoying bell

- Set-PSReadLineOption -BellStyle None

# install scoop for package manegement 

- Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
- Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# add aria for multiconnection downloads

- scoop install aria2

# install sudo for global installs (with admin rights)

- scoop install sudo

# add git

scoop install git

# add other buckets normally needed.

scoop bucket add nerd-fonts
scoop bucket add extras

# fzf

- scoop install fzf
- Install-Module -Name PSFzf -AllowClobber

and add the following to $profile

- Import-Module PSFzf
- Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
