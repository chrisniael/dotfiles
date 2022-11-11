#!/bin/bash

sudo pacman -S zsh neovim clang nodejs npm ripgrep xsel ttf-hack-nerd git exa tmux

git clone https://github.com/chrisniael/dotfiles.git $HOME/dotfiles

# Install ohmyzh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
/bin/rm -f .zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/
source $HOME/.zshrc

# npm config
ln -s $HOME/.dotfiles/.npmrc $HOME/
NPM_PACKAGES="${HOME}/.npm"
/bin/mkdir -p $NPM_PACKAGES
npm config set prefix $NPM_PACKAGES
npm install neovim -g

# Install pynvim
pip install pynvim

# gem config
ln -s $HOME/.dotfiles/.gemrc $HOME/


# Neovim config
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -s $HOME/.dosfiles/.config/nvim  $HOME/.config/
nvim -c 'PlugInstall --sync|qa'
nvim -c 'CocUpdateSync|q'


# tmux config
# TODO: 安装 tmux 插件
ln -s $HOME/.dotfiles/.tmux.conf $HOME/
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

