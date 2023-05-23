# powerlevel10k 主题
# https://github.com/romkatv/powerlevel10k
# 安装
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
# 更新
# git -C ~/.powerlevel10k pull
[[ ! -f ~/.powerlevel10k/powerlevel10k.zsh-theme ]] || source ~/.powerlevel10k/powerlevel10k.zsh-theme

# 启用补全
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# 记录历史记录
SAVEHIST=50000
HISTFILE=$HOME/.zsh_history

# Ctrl-u 行为与 bash 一致
# https://stackoverflow.com/a/3483679
bindkey \^U backward-kill-line

export LANG=en_US.UTF-8
export XAUTHORITY=$HOME/.Xauthority
export EDITOR=nvim

# luarocks 配置
# luarocks path
export PATH="$PATH:$HOME/.luarocks/bin"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

NPM_PACKAGES="${HOME}/.npm"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH}:$NPM_PACKAGES/share/man"

export PATH="$PATH:$GEM_HOME/bin"

export PATH="$PATH:$GOPATH/bin"

export PATH="$HOME/.local/bin:$PATH"

# Add by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

alias gdb='EDITOR="nvim -R" gdb'
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

# # XShell 终端类型里没有 xterm-256color 选项，需要手动设置
# # tmux 里不可以手动设置，tmux 本身配置里有对 TERM 设置
# # TERM 会影响 ohmyzsh 的 ATUO_TITLE 功能
# export TERM='xterm-256color'

# # 手动更新 tmux session 的 zsh 环境变量
# # https://babushk.in/posts/renew-environment-tmux.html
# function preexec {
#     eval "$(tmux show-environment -s)"
# }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
