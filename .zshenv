export LANG=en_US.UTF-8
export XAUTHORITY=$HOME/.Xauthority
export EDITOR=nvim

# Fcitix 5 配置
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

# Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# luarocks 配置
export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;$HOME/.luarocks/share/lua/5.4/?.lua;$HOME/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/lib/lua/5.4/?.so;/usr/lib/lua/5.4/loadall.so;./?.so;$HOME/.luarocks/lib/lua/5.4/?.so'
export PATH="$HOME/.luarocks/bin:$PATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

NPM_PACKAGES="${HOME}/.npm"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH}:$NPM_PACKAGES/share/man"

# Install Ruby Gems to ~/.gems
# https://stackoverflow.com/a/55076591
export GEM_HOME=$HOME/.gems
export PATH="$PATH:$GEM_HOME/bin"

export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.local/share/nvim/plugged/asynctasks.vim/bin:$PATH"

