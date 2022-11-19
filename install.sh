#!/bin/bash

sudo pacman -S base-devel zsh neovim clang nodejs npm ripgrep xclip ttf-hack-nerd git exa tmux tree-sitter delve fzf

git clone https://github.com/chrisniael/dotfiles.git $HOME/.dotfiles

# Install ohmyzh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
/bin/rm -f .zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/
source $HOME/.zshrc

# npm config
# NPM_PACKAGES="${HOME}/.npm"
# /bin/mkdir -p $NPM_PACKAGES
# npm config set prefix $NPM_PACKAGES
ln -s $HOME/.dotfiles/.npmrc $HOME/

# gem config
ln -s $HOME/.dotfiles/.gemrc $HOME/

# Neovim config
pip install pynvim
pip install pyre2
pip install cmakelang
npm install neovim -g
gem install neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir $HOME/.config
ln -s $HOME/.dotfiles/.config/nvim  $HOME/.config/
nvim -c 'PlugInstall --sync|qa'
nvim -c 'CocUpdateSync|q'
nvim -c 'TSInstallSync all|q'


# tmux config
# TODO: 安装 tmux 插件
ln -s $HOME/.dotfiles/.tmux.conf $HOME/
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
