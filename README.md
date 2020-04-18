# Dotfiles

My dotfiles.

Compatiable with Arch, Ubuntu 19.10 and macOS.

## Install

```bash
git clone https://github.com/chrisniael/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## powerline-status

* python >= 3.7
* pip

```bash
# Ubuntu
su -
apt install python3 python3-pip
pip3 install powerline-status
```

```bash
# Arch
su -
pacman -S python python-pip
pip install powerline-status
```

## zsh

* zsh >= 4.3.9
* ohmyzsh

## tmux

* tmux > 3.0
* tmp

```bash
# Ubuntu
# Install the newest tmux mannually in Ubuntu.
apt install autoconf automake pkgconf libevent-dev libncurses-dev bison
git clone https://github.com/tmux/tmux.git
cd tmux
# git checkout 3.1
./autogen.sh
./configure
make
make install
```

```bash
# Arch
pacman -S tmux
```

Install tpm.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## vim

* neovim >= 0.3.1 or vim >= 8.0.1453
* node >= 8.10.0
* vim-plugin
* xsel
* pynvim (python)
* neovim (nodejs)
* coc-yank
* coc-lists
* ripgrep
* clangd
* bash-language-server

Install newest neovim.

```bash
su -
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod a+x nvim.appimage
./nvim.appimage --appimage-extract
cd squashfs-root
find . -type d -exec chmod 755 {} \;
cd ../
mv squashfs-root /
```

Then just put `/squashfs-root/usr/bin` in user's `PATH` environment variable.

Install dependency using root.

```bash
# Ubuntu
su -
apt install clang-format nodejs npm ripgrep xsel
pip3 install pynvim
npm install -g neovim
npm install -g bash-language-server
```

```bash
# Arch
pacman -S clang nodejs npm ripgrep xsel
pip install pynvim
npm install -g neovim
npm install -g bash-language-server
```

Install vim-plugin, config neovim and install all plugins.

```bash
# First of all, copy config to home directory
# cp .vimrc ~/.vimrc
# cp -r .vim ~/.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

nvim +PluginUpdate  # not working, just open vim and run :PluginUpdate manually
nvim "+CocStart" "+CocInstall -sync coc-lists" "+qa"
nvim "+CocStart" "+CocInstall -sync coc-yank" "+qa"
nvim "+CocStart" "+CocInstall -sync coc-markdownlint" "+qa"
```
