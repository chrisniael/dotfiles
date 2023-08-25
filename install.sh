#!/bin/bash

git clone https://github.com/chrisniael/dotfiles.git $HOME/.dotfiles

# 系统常用软件
sudo pacman -S base-devel net-tools tree

# Install man page
sudo pacman -S man-db man-pages

# zsh config
#------------------------------------------------
sudo pacman -S zsh
sudo pacman -S exa
sudo pacman -S ttf-hack-nerd

# Change default shell to zsh
chsh -s /usr/bin/zsh

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
/bin/rm -f .zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/
source $HOME/.zshrc
#------------------------------------------------


# npm config
#------------------------------------------------
sudo pacman -S nodejs npm
# NPM_PACKAGES="${HOME}/.npm"
# /bin/mkdir -p $NPM_PACKAGES
# npm config set prefix $NPM_PACKAGES
ln -s $HOME/.dotfiles/.npmrc $HOME/
#------------------------------------------------


# gem config
#------------------------------------------------
ln -s $HOME/.dotfiles/.gemrc $HOME/
#------------------------------------------------


# Neovim config
#------------------------------------------------
sudo pacman -S neovim
sudo pacman -S ripgrep
sudo pacman -S clang
sudo pacman -S xclip
sudo pacman -S delve
sudo pacman -S ttf-hack-nerd

pip install --break-system-packages --user pynvim
pip install --break-system-packages --user cmakelang

npm install neovim -g
npm install bash-language-server -g

gem install neovim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir $HOME/.config
ln -s $HOME/.dotfiles/.config/nvim  $HOME/.config/
nvim -c 'PlugInstall --sync|qa'
#------------------------------------------------


# tmux config
#------------------------------------------------
# TODO: 安装 tmux 插件
sudo pacman -S tmux
ln -s $HOME/.dotfiles/.tmux.conf $HOME/
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
#------------------------------------------------


# git config
#------------------------------------------------
sudo pacman -S git git-delta
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
#------------------------------------------------
