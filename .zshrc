# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -n "$TMUX" ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
else
  if [[ "$TERM_PROGRAM" = "Apple_Terminal" ]] || [[ "$TERM_PROGRAM" = "iTerm.app" ]] ; then
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
  fi
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

if [[ -n "$TMUX" ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  if [[ "$TERM_PROGRAM" = "Apple_Terminal" ]] || [[ "$TERM_PROGRAM" = "iTerm.app" ]] ; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
  else
    ZSH_THEME="robbyrussell"
  fi
fi

DISABLE_AUTO_UPDATE="true"

# 安装 zsh-vim-mode
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-vim-mode ]]; then
  git clone https://github.com/softmoth/zsh-vim-mode.git $HOME/.oh-my-zsh/custom/plugins/zsh-vim-mode
fi
plugins=(docker rust golang zsh-vim-mode)

source $ZSH/oh-my-zsh.sh


#----------------------------------------------------------------------
# User configuration
#----------------------------------------------------------------------
# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# 确保 source ~/.zshrc 的时候不会重复追加 PATH 的值
if [[ -z "$TMUX" ]]; then
  if [[ -z "$ORIGIN_PATH" ]]; then
    export ORIGIN_PATH=$PATH
  else
    export PATH=$ORIGIN_PATH
  fi
else
  export PATH=$ORIGIN_PATH
fi

OS=$(uname)

if [[ "${OS}" == "Darwin" ]]; then
  # 检测是否存在 exa 命令
  if hash exa >/dev/null 2>&1; then
    alias ls='exa -F'
    alias ll='exa -lF'
    alias la='exa -laF'
  else
    alias ls="ls -FhOT"
    alias ll="ls -lFhOT"
    alias la="ls -laFhOT"
  fi
  alias lldb="PATH=/usr/bin /usr/bin/lldb"
  alias ssh-over-ss="ssh -o ProxyCommand='nc -x 127.0.0.1:1081 %h %p'"
  alias htop="TERM=xterm-256color htop"

  # 更新所有 cask
  function brew-cask-upgrade() {
    # 去除末尾的空格
    local cask_list=$(eval echo $(brew outdated --cask --greedy --verbose | grep -v '!= latest' | awk -F ' ' '{print $1}' | tr '\n' ' '))
    # 不用 eval 会导致多个 token 的时候不被当成多参数
    eval brew upgrade --cask $cask_list
  }

  export CLICOLOR=1
  export LSCOLORS=exfxcxdxbxegedabagacad

  # Fix GitHub API rate limit exceeded
  export HOMEBREW_GITHUB_API_TOKEN=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

  export PATH="/usr/local/sbin:$PATH"
  export PATH="/usr/local/opt/ruby/bin:$PATH"
  export PATH="/usr/local/opt/openssl/bin:$PATH"
  export PATH="/usr/local/opt/sqlite/bin:$PATH"
  # export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
  export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/ncurses/bin:$PATH"
  export PATH=$PATH:/usr/local/opt/llvm/bin
  # 这个命令会让 zsh 启动变特别慢, 直接指定路径加速启动
  # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
  # export HOMEBREW_NO_AUTO_UPDATE=true

  # GCC/Clang 默认搜索路径
  export C_INCLUDE_PATH="$C_INCLUDE_PATH:/usr/local/include"
  export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/local/include"
  export OBJC_INCLUDE_PATH="$OBJC_INCLUDE_PATH:/usr/local/lib"
else
  if hash exa >/dev/null 2>&1; then
    alias ls='exa -F'
    alias ll='exa -lF'
    alias la='exa -laF'
  else
    alias ls="ls -Fh --color"
    alias ll="ls -lF --color"
    alias la="ls -laFh --color"
  fi

  if [[ "${OS}" == "Linux" ]]; then
    source /etc/os-release
    case "${ID}" in
      arch|manjaro)
        alias gdb="sudo gdb"

        export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
        ;
        ;;
      ubuntu)
        ;;
      centos)
        ;;
      *)
        ;;
    esac
  fi
fi

if [[ -d $HOME/.go ]]; then
  export GOPATH="$HOME/.go"
  export PATH="$PATH:$GOPATH/bin"
fi

if [[ -d $HOME/.bin ]]; then
  export PATH="$HOME/.bin:$PATH"
fi

if [[ -d $HOME/.local/share/nvim/plugged/asynctasks.vim/bin ]]; then
  export PATH="$HOME/.local/share/nvim/plugged/asynctasks.vim/bin:$PATH"
  alias t='asynctask -f'
fi

alias rm="rm -i"                            #"删除"
alias cp="cp -i"                            #"复制"
alias mv="mv -i"                            #"移动"
alias mkdir="mkdir -v"                      #"新建时会提示
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} --line-buffered"
alias vim="nvim"

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

if [[ "$(uname -r | grep -Eo Microsoft)" == "Microsoft" ]]; then
  # WSL not apply umask corrent.
  if [[ "$(umask)" = "000" ]]; then
    umask 022
  fi

  # WSL local not auto set DISPLAY variable
  if [[ -z "$SSH_CONNECTION" ]]; then
    export DISPLAY=:0.0
  fi
fi

if [[ -n "$NVIM_LISTEN_ADDRESS" ]]; then
  if [ -d $HOME/.local/share/nvim/plugged/vim-floaterm/bin ]; then
    export PATH="$HOME/.local/share/nvim/plugged/vim-floaterm/bin:$PATH"
    alias vim="floaterm"
  fi
fi

export LANG=en_US.UTF-8
export XAUTHORITY=$HOME/.Xauthority
export EDITOR=nvim

# ulimit -c unlimited
# ulimit -n 20480

# 加载自定义配置
if [ -f "${HOME}/.zshrc_local" ]; then
  source "${HOME}/.zshrc_local"
fi

## tmux 启动的时候存在 attached 的 session 则 attach 它并剔除所有其他客户端，不存在则创建一个新的
## 仅仅 ssh 连接时自动启动 tmux
if [[ -z "$TMUX" ]]; then
  # 不是 vim/neovim 的 terminal 启动的 zsh
  if [[ -z "$NVIM_LISTEN_ADDRESS" ]]; then
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
  if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]] && [[ "$TERM_PROGRAM" != "iTerm.app" ]] ; then
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
  if [[ -z "$NVIM_LISTEN_ADDRESS" ]]; then
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
