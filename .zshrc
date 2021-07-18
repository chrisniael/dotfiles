# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# 使用 powerline 主题时，注释掉 ZSH_THEME 和 DEFAULT_USER 变量
# pip install powerline-status
OS=$(uname -s)
if [[ "${OS}" == "Darwin" ]]; then
  # 当终端是 Apple Terminal 时，不使用 powerline，powerline 暂时不能自动判断终端类型来关闭 true color
  if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]
  then
    ZSH_THEME="robbyrussell"
  else
    powerline-daemon -q
    source /usr/local/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh
  fi
elif [[ "${OS}" == "Linux" ]]; then
  source /etc/os-release
  case "${ID}" in
    arch | manjaro)
      powerline-daemon -q
      source /usr/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh
      ;;
    ubuntu)
      powerline-daemon -q
      source /usr/local/lib/python3.7/dist-packages/powerline/bindings/zsh/powerline.zsh
      ;;
    centos)
      powerline-daemon -q
      source /usr/local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
      ;;
    *)
      DEFAULT_USER="shenyu"
      ZSH_THEME="agnoster"
      ;;
  esac
else
  DEFAULT_USER="shenyu"
  ZSH_THEME="agnoster"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# zsh-vim-mode 安装
# cd $ZSH_CUSTOM/plugins
# git clone https://github.com/softmoth/zsh-vim-mode.git
if [ -d $HOME/.oh-my-zsh/custom/plugins/zsh-vim-mode ]; then
  plugins=(docker cargo rust golang zsh-vim-mode)
else
  plugins=(docker cargo rust golang)
fi

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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

  export GOPATH="/Users/shenyu/Documents/go"

  export PATH="/usr/local/sbin:$PATH"
  export PATH="/usr/local/opt/ruby/bin:$PATH"
  export PATH="/usr/local/opt/openssl/bin:$PATH"
  export PATH="/usr/local/opt/sqlite/bin:$PATH"
  # export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
  export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/ncurses/bin:$PATH"
  export PATH=$PATH:/usr/local/opt/llvm/bin
  export PATH=$PATH:$GOPATH/bin
  # 这个命令会让 zsh 启动变特别慢, 直接指定路径加速启动
  # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
  export HOMEBREW_NO_AUTO_UPDATE=true

  bindkey \^U backward-kill-line
  bindkey '\e[1~' beginning-of-line
  bindkey '\e[4~' end-of-line
else
  alias ls="ls -Fh --color"
  alias ll="ls -lF --color"
  alias la="ls -laFh --color"

  if [[ "${OS}" == "Linux" ]]; then
    source /etc/os-release
    case "${ID}" in
      arch|manjaro)
        alias gdb="sudo gdb"

        export GOPATH="$HOME/Documents/go"

        export PATH="$PATH:$GOPATH/bin"
        export PATH="/squashfs-root/usr/bin:$PATH"
        export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
        ;
        ;;
      ubuntu)
        ;;
      centos)
        export PATH="/squashfs-root/usr/bin:$PATH"
        ;;
      *)
        ;;
    esac
  fi
fi

if [[ -d $HOME/.config/bin ]]; then
  export PATH="$HOME/.config/bin:$PATH"
fi

if [[ -d $HOME/.vim/plugged/asynctasks.vim/bin ]]; then
  export PATH="$HOME/.vim/plugged/asynctasks.vim/bin:$PATH"
  alias t='asynctask -f'
fi

alias rm="rm -i"                            #"删除"
alias cp="cp -i"                            #"复制"
alias mv="mv -i"                            #"移动"
alias mkdir="mkdir -v"                      #"新建时会提示
alias vim="nvim"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} --line-buffered"

function unproxy() {
  unset {http,https,ftp,rsync,all}_proxy
  unset {HTTP,HTTPS,FTP,RSYNC,ALL}_PROX
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

  # WSL local nost auto set DISPLAY variable
  if [[ -z "$SSH_CONNECTION" ]]; then
    export DISPLAY=:0.0
  fi
fi


if [[ -n "$NVIM_LISTEN_ADDRESS" ]]; then
  if [ -d $HOME/.vim/plugged/vim-floaterm/bin ]; then
    export PATH="$HOME/.vim/plugged/vim-floaterm/bin:$PATH"
    alias vim="floaterm"
  fi
fi

export LANG=en_US.UTF-8
export XAUTHORITY=$HOME/.Xauthority
export EDITOR=nvim

ulimit -c unlimited
ulimit -n 20480

bindkey \^U backward-kill-line
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# tmux 启动的时候存在 attached 的 session 则 attach 它并剔除所有其他客户端，不存在则创建一个新的
# 仅仅 ssh 连接时自动启动 tmux
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
  if [[ -n "$SSH_CONNECTION" ]]; then
    # 用 eval 是去除前后的空格， mac 上的 wc 命令与 linux 不太一样，会输出一些空格
    if [[ $(eval echo $(tmux list-sessions 2>/dev/null | wc -l)) = 0 ]]; then
      tmux new-session
    else
      ID="$(tmux list-sessions 2>/dev/null | grep -m1 attached | cut -d: -f1)"
      if [[ -n "$ID" ]]; then
        killall xclip >/dev/null 2>&1; tmux attach-session -d -x -t "$ID"
      else
        killall xclip >/dev/null 2>&1; tmux attach-session -d -x
      fi
    fi
  fi
else
  # exit ssh 连接的时候，关闭 xclip child process，否则 ssh 连接不会关掉
  # exit 的时候如果在 tmux 是最后一个 session 窗口，则关闭 xclip child process 且断开 ssh 连接
  # 不在 tmux 则只关闭 xclip child process 且 exit
  #
  # 关闭 xclip child process 的原因是因为 xclip 会保持和 X Server 的连接，exit 的时候会不能正常关闭 SSH 连接
  # 用 eval 是去除前后的空格， mac 上的 wc 命令与 linux 不太一样，会输出一些空格
  if [[ -z "$NVIM_LISTEN_ADDRESS" ]]; then
    exit() {
      if [[ $(eval echo $(tmux list-sessions | wc -l)) = 1 ]] && [[ $(eval echo $(tmux list-windows | wc -l)) = 1 ]] && [[ $(eval echo $(tmux list-panes | wc -l)) = 1 ]]; then
        killall xclip >/dev/null 2>&1; tmux detach -P
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

# 加载自定义配置
if [ -f "${HOME}/.zshrc_custom" ]; then
  source "${HOME}/.zshrc_custom"
fi

u()
{
  # 升级 ohmyzsh
  # Note: `upgrade_oh_my_zsh` is deprecated. Use `omz update` instead.
  which omz >/dev/null 2>&1
  if [ $? = 0 ]; then
    omz update
  fi
  # 升级 brew
  hash brew >/dev/null 2>&1
  if [ $? = 0 ]; then
    echo "Upgrading brew"
    brew update
    brew upgrade
    brew-cask-upgrade
  fi
  # 升级 vim 插件
  vim +'PlugUpgrade' +qa
  vim +'PlugInstall --sync' +qa
  vim +'PlugUpdate --sync' +qa
  # 升级 coc 插件
  vim +'CocStart' +'CocUpdateSync' +qa
}
