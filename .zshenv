# 需要 export 给 X11 应用程序的环境变量设置在这里

# go
export GOPATH="$HOME/.go"

# luarocks
export LUA_PATH=";;$HOME/.luarocks/share/lua/5.4/?.lua;$HOME/.luarocks/share/lua/5.4/?/init.lua"
export LUA_CPATH=";;$HOME/.luarocks/lib/lua/5.4/?.so"

# Install Ruby Gems to ~/.gems
# https://stackoverflow.com/a/55076591
export GEM_HOME=$HOME/.gems

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

