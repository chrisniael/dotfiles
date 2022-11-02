$env:TERM = "xterm-256color"
$env:LANG= "en_US.UTF-8"

# For dlv edit command use
$env:EDITOR= "nvim"

# C/CXX Compiler
$env:CC="clang.exe"
$env:CXX="clang++.exe"

Set-Alias -Name nvim -Value C:\Users\shenyu\scoop\apps\neovim\current\bin\nvim-qt.exe
Set-Alias -Name vim -Value nvim
Set-Alias -Name grep -Value findstr

# posh-git
# https://github.com/dahlbyk/posh-git
Import-Module posh-git

# PSReadLine
# https://github.com/PowerShell/PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
# Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -PredictionViewStyle ListView

# Terminal-Icons
# https://github.com/devblackops/Terminal-Icons
Import-Module Terminal-Icons
# Set-TerminalIconsTheme -DisableIconTheme

# oh-my-posh 
# https://github.com/JanDeDobbeleer/oh-my-posh
# winget install JanDeDobbeleer.OhMyPosh -s winget
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\pure.omp.json | Invoke-Expression

function proxy {
  $env:http_proxy="http://127.0.0.1:7890";$env:https_proxy="http://127.0.0.1:7890"
  curl -s ipinfo.io
}

function unproxy {
  $env:http_proxy="";$env:https_proxy=""
}

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
