# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

DISABLE_AUTO_UPDATE="true"

plugins=()

# zsh-completions
# 命令补全
# https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh


#----------------------------------------------------------------------
# User configuration
#----------------------------------------------------------------------
# Ctrl-u 行为与 bash 一致
# https://stackoverflow.com/a/3483679
bindkey \^U backward-kill-line

export LANG=en_US.UTF-8
export XAUTHORITY=$HOME/.Xauthority
export EDITOR=nvim

alias gdb="sudo gdb"
alias ls='exa -F'
alias ll='exa -lF'
alias la='exa -laF'
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -v"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} --line-buffered"

function unproxy() {
  unset {http,https,ftp,rsync,all}_proxy
  unset {HTTP,HTTPS,FTP,RSYNC,ALL}_PROXY
  unset ELECTRON_GET_USE_PROXY
  unset GLOBAL_AGENT_HTTP_PROXY
  unset GLOBAL_AGENT_HTTPS_PROXY
}

function proxy() {
  # ~/.proxy : 代理的用户名、密码、 ip 和 port, 格式:
  # HTTP_PROXY_USERNAME=shenyu
  # HTTP_PROXY_PASSWORD=123456
  # HTTP_PROXY_IP=127.0.0.1
  # HTTP_PROXY_PORT=7890
  if [[ -f $HOME/.proxy ]]; then
    source $HOME/.proxy
    if [[ -n "$HTTP_PROXY_USERNAME" ]] && [[ -n "$HTTP_PROXY_IP" ]] && [[ -n "$HTTP_PROXY_PORT" ]]; then
      unproxy
      if [[ -n "$HTTP_PROXY_PASSWORD" ]]; then
        local proxy_url=http://${HTTP_PROXY_USERNAME}:${HTTP_PROXY_PASSWORD}@${HTTP_PROXY_IP}:${HTTP_PROXY_PORT}
      else
        local proxy_url=http://${HTTP_PROXY_USERNAME}@${HTTP_PROXY_IP}:${HTTP_PROXY_PORT}
      fi

      export {http,https,ftp,rsync,all}_proxy=$proxy_url
      export {HTTP,HTTPS,FTP,RSYNC,ALL}_PROXY=$proxy_url

      # electron 代理配置
      # https://rabbitfeet.net/archives/npm安装Electron慢的解决方案
      export ELECTRON_GET_USE_PROXY=1
      export GLOBAL_AGENT_HTTP_PROXY=$proxy_url
      export GLOBAL_AGENT_HTTPS_PROXY=$proxy_url
      curl -s ipinfo.io
    fi
  fi
}

# ulimit -c unlimited
# ulimit -n 20480

# 加载自定义配置
if [ -f "${HOME}/.zshrc_local" ]; then
  source "${HOME}/.zshrc_local"
fi

# tmux 启动的时候存在 attached 的 session 则 attach 它并剔除所有其他客户端，不存在则创建一个新的
if [[ -z "$TMUX" ]]; then
  # 不是 vim/neovim 的 terminal 启动的 zsh
  if [[ -z "$NVIM" ]]; then
    exit() {
      killall xclip >/dev/null 2>&1
      unset -f exit
      exit
    }
  fi

  # XShell 终端类型里没有 xterm-256color 选项，需要手动设置
  # tmux 里不可以手动设置，tmux 本身配置里有对 TERM 设置
  # TERM 会影响 ohmyzsh 的 ATUO_TITLE 功能
  export TERM='xterm-256color'

  # 仅仅通过 ssh 连接时自动启动 tmux
  if [[ -n "$SSH_CONNECTION" ]] && [[ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
    # 用 eval 是去除前后的空格， mac 上的 wc 命令与 linux 不太一样，会输出一些空格
    if [[ $(eval echo $(tmux list-sessions 2>/dev/null | wc -l)) = 0 ]]; then
      exec tmux new-session
    else
      ID="$(tmux list-sessions 2>/dev/null | grep -m1 attached | cut -d: -f1)"
      if [[ -n "$ID" ]]; then
        killall xclip >/dev/null 2>&1
        exec tmux attach-session -d -x -t "$ID"
      else
        killall xclip >/dev/null 2>&1
        exec tmux attach-session -d -x
      fi
    fi
  else
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  fi
else
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

  # exit ssh 连接的时候，关闭 xclip child process，否则 ssh 连接不会关掉
  # exit 的时候如果在 tmux 是最后一个 session 窗口，则关闭 xclip child process 且断开 ssh 连接
  # 不在 tmux 则只关闭 xclip child process 且 exit
  #
  # 关闭 xclip child process 的原因是因为 xclip 会保持和 X Server 的连接，exit 的时候会不能正常关闭 SSH 连接
  # 用 eval 是去除前后的空格， mac 上的 wc 命令与 linux 不太一样，会输出一些空格
  if [[ -z "$NVIM" ]]; then
    exit() {
      if [[ $(eval echo $(tmux list-sessions | wc -l)) = 1 ]] && [[ $(eval echo $(tmux list-windows | wc -l)) = 1 ]] && [[ $(eval echo $(tmux list-panes | wc -l)) = 1 ]]; then
        killall xclip >/dev/null 2>&1
        clear
        tmux detach -P
      else
        unset -f exit
        exit
      fi
    }
  fi

  # 手动更新 tmux session 的 zsh 环境变量
  # https://babushk.in/posts/renew-environment-tmux.html
  function preexec {
    eval "$(tmux show-environment -s)"
  }
fi
