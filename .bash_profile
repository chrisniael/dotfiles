#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

NPM_PACKAGES="${HOME}/.npm"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH}:$NPM_PACKAGES/share/man"

# go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# Install Ruby Gems to ~/.gems
# https://stackoverflow.com/a/55076591
export GEM_HOME=$HOME/.gems
export PATH="$PATH:$GEM_HOME/bin"
