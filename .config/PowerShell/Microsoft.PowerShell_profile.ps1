# git clone git@github.com:chrisniael/dotfiles.git ~/.dotfiles
# Windows PowerShell 设置配置
# New-Item -Path C:\Users\shenyu\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value C:\Users\shenyu\Documents\git-repo\dotfiles\.config\powershell\Microsoft.PowerShell_profile.ps1
# PowerShell 设置配置
# New-Item -Path C:\Users\shenyu\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value C:\Users\shenyu\Documents\git-repo\dotfiles\.config\powershell\Microsoft.PowerShell_profile.ps1
$env:TERM = "xterm-256color"
$env:LANG= "en_US.UTF-8"

# For dlv edit command use
$env:EDITOR= "nvim"

# C/CXX Compiler
# $env:CC="clang.exe"
# $env:CXX="clang++.exe"

Set-Alias -Name grep -Value findstr

# [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

# posh-git
# https://github.com/dahlbyk/posh-git
# 安装
# PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
# 更新
# PowerShellGet\Update-Module posh-git
Import-Module posh-git

# PSReadLine
# https://github.com/PowerShell/PSReadLine
# 安装
# PowerShellGet\Install-Module PSReadLine -Scope CurrentUser -Force
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource None

# Terminal-Icons
# https://github.com/devblackops/Terminal-Icons
# 安装
# PowerShellGet\Install-Module Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force
Import-Module Terminal-Icons
# Set-TerminalIconsTheme -DisableIconTheme

# oh-my-posh 
# https://github.com/JanDeDobbeleer/oh-my-posh
# 安装
# winget install JanDeDobbeleer.OhMyPosh -s winget
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\pure.omp.json | Invoke-Expression

function proxy {
  $env:http_proxy="http://127.0.0.1:7890";$env:https_proxy="http://127.0.0.1:7890"
  # 为了兼容 windows 自带的 powershell，这里必须写成 curl.exe 而不是 curl
  curl.exe -s ipinfo.io
}

function unproxy {
  $env:http_proxy="";$env:https_proxy=""
}
