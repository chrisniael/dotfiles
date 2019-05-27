#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '

alias ls="ls -Fh --color"
alias ll="ls -lFh --color"
alias la="ls -laFh --color"
alias rm="rm -i"                            #"删除"
alias cp="cp -i"                            #"复制"
alias mv="mv -i"                            #"移动"
alias mkdir="mkdir -v"                      #"新建时会提示
alias ssproxy="export http_proxy=http://127.0.0.1:8118;export https_proxy=http://127.0.0.1:8118;curl google.com"
alias unssproxy="unset http_proxy;unset https_proxy"

export LANG="en_US.UTF-8"
export PS1="\[\e[0;32m\][\[\e[0;31m\]\u\[\e[0;36m\]@\[\e[0;33m\]\h\[\e[0;34m\]:\[\e[0;35m\]\w\[\e[0;32m\]] \[\e[0;37m\]$ \[\e[0m\]"
export no_proxy="127.0.0.1, localhost"

ulimit -c unlimited

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi
