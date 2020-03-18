# dotfiles-arch

Arch Linux dotfiles.

Compatiable with Arch, Ubuntu 19.10, macOS.


## powerline-status

* python
* pip

```bash
# Ubuntu
su -
apt install python3 python3-pip
pip3 install powerline-status
```


## zsh

* zsh >= 4.3.9 
* ohmyzsh


## tmux

* tmux > 3.0
* tmp

Install the newest tmux mannually in Ubuntu.

```bash
# Ubuntu
apt install autoconf automake pkgconf libevent-dev libncurses-dev bison
git clone https://github.com/tmux/tmux.git
# git checkout 3.1
./autogen.sh
./configure
make
make install
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

Install dependency using root in Ubuntu.

```bash
# Ubuntu
su -
apt install clang-format nodejs npm ripgrep xsel
pip3 install pynvim
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

nvim +PluginUpdate +qa
nvim "+CocStart" "+CocInstall coc-lists" +qa
nvim "+CocStart" "+CocInstall coc-yank" +qa"
```
