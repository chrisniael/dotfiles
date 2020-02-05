# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/shenyu/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# DEFAULT_USER="shenyu"

# 使用 powerline 主题时，注释掉 ZSH_THEME 变量
powerline-daemon -q
source /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(zsh-completions docker)
plugins=(docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ls="ls -Fh --color"
alias ll="ls -lF --color"
alias la="ls -laFh --color"
alias rm="rm -i"                            #"删除"
alias cp="cp -i"                            #"复制"
alias mv="mv -i"                            #"移动"
alias mkdir="mkdir -v"                      #"新建时会提示
alias ssproxy="export http_proxy=\"http://10.246.34.83:8001\"; export HTTP_PROXY=\"http://10.246.34.83:8001\"; export https_proxy=\"http://10.246.34.83:8001\"; export HTTPS_PROXY=\"http://10.246.34.83:8001\"; curl google.com"
alias unssproxy="unset http_proxy; unset https_proxy; unset HTTP_PROXY; unset HTTPS_PROXY"
alias gdb="sudo gdb"
alias vim="/squashfs-root/usr/bin/nvim"
# exit ssh 连接的时候，关闭 xsel child process，否则 ssh 连接不会关掉
# exit 的时候如果在 tmux 是最后一个 session 窗口，则关闭 xsel child process 且断开 ssh 连接
# 不在 tmux 则只关闭 xsel child process 且 exit
#
# 关闭 xsel child process 的原因是因为 xsel 会保持和 X Server 的连接，exit 的时候会不能正常关闭 SSH 连接
alias exit='if [[ -n "$TMUX" ]]; then if [[ $(tmux list-sessions | wc -l) = 1 ]] && [[ $(tmux list-windows | wc -l) = 1 ]] && [[ $(tmux list-panes | wc -l) = 1 ]]; then echo "This is the last pane, you can not close it!"; else exit; fi; else killall xsel >/dev/null 2>&1 ; exit; fi'

export LANG=en_US.UTF-8
export no_proxy="127.0.0.1, localhost, gitlab.corp.sdo.com"

export GOPATH="$HOME/Documents/go"
export PATH="$PATH:$GOPATH/bin"

# XShell 终端类型里没有 xterm-256color 选项，兼容处理
if [[ "$TERM" = "xterm" ]]; then
  export TERM=xterm-256color
fi

export XAUTHORITY=$HOME/.Xauthority

ulimit -c unlimited
ulimit -n 20480

bindkey \^U backward-kill-line
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# TMUX 启动的时候存在 eattached 的session 则 attach 它并剔除所有其他客户端，不存在则创建一个新的
if [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]] ;then
  if [[ $(tmux list-sessions 2>/dev/null | wc -l) = 0 ]] ;then
    tmux new-session
  else
    ID="$(tmux list-sessions 2>/dev/null | grep -m1 attached | cut -d: -f1)"
    if [[ -n "$ID" ]] ;then
      killall xsel >/dev/null 2>&1; tmux attach-session -d -x -t "$ID"
    else
      killall xsel >/dev/null 2>&1; tmux attach-session -d -x
    fi
  fi
fi


DISABLE_AUTO_TITLE="true"
if [[ -z "$SSH_CONNECTION" ]] ;then
  function precmd () {
    window_title="\033]0;${PWD/#${HOME}/~}\007"
    echo -ne "$window_title"
  }
else
  function precmd () {
    window_title="\033]0;${USER}@${HOST}:${PWD/#${HOME}/~}\007"
    echo -ne "$window_title"
  }
fi
