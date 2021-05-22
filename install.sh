#!/bin/bash

PROJECT_DIR=$(pwd)

ZSH_CONFIG_FILENAME=.zshrc
TMUX_CONFIG_FILENAME=.tmux.conf
GIT_CONFIG_FILENAME=.gitconfig
VIM_CONFIG_DIRNAME=.vim
VIM_CONFIG_FILENAME=.vimrc

ZSH_CONFIG_FILE=$HOME/$ZSH_CONFIG_FILENAME
TMUX_CONFIG_FILE=$HOME/$TMUX_CONFIG_FILENAME
GIT_CONFIG_FILE=$HOME/$GIT_CONFIG_FILENAME
VIM_CONFIG_DIR=$HOME/$VIM_CONFIG_DIRNAME
VIM_CONFIG_FILE=$HOME/$VIM_CONFIG_FILENAME
NEOVIM_CONFIG_DIR=$HOME/.config/nvim
NEOVIM_CONFIG_FILE=$HOME/.vim/init.vim

PROJECT_ZSH_CONFIG_FILE=$PROJECT_DIR/$ZSH_CONFIG_FILENAME
PROJECT_TMUX_CONFIG_FILE=$PROJECT_DIR/$TMUX_CONFIG_FILENAME
PROJECT_GIT_CONFIG_FILE=$PROJECT_DIR/$GIT_CONFIG_FILENAME
PROJECT_VIM_CONFIG_DIR=$PROJECT_DIR/$VIM_CONFIG_DIRNAME
PROJECT_VIM_CONFIG_FILE=$PROJECT_DIR/$VIM_CONFIG_FILENAME

function ln_file() {
  ORI_FILE=$1
  DST_FILE=$2
  if [ -L ${DST_FILE} ]
  then
    /bin/rm -f ${DST_FILE}
  elif [ -f ${DST_FILE} ]
  then
    /bin/mv -f ${DST_FILE} ${DST_FILE}.backup
    echo "Backup old ${DST_FILE} to ${DST_FILE}.backup"
  else
    echo "Error: ${DST_FILE} is not a symbolic link file or regular file."
  fi

  ln -s $ORI_FILE $DST_FILE
}

function ln_dir() {
  ORI_DIR=$1
  DST_DIR=$2
  if [ -L ${DST_DIR} ]
  then
    /bin/rm -f ${DST_DIR}
  elif [ -d ${DST_DIR} ]
  then
    /bin/mv -f ${DST_DIR} ${DST_DIR}.backup
    echo "Backup old ${DST_DIR} to ${DST_DIR}.backup"
  else
    echo "Error: ${DST_DIR} is not a symbolic link file or regular file."
  fi

  ln -s $ORI_DIR $DST_DIR
}

# link ~/.zshrc
ln_file $PROJECT_ZSH_CONFIG_FILE $ZSH_CONFIG_FILE

# link ~/.tmux.conf
ln_file $PROJECT_TMUX_CONFIG_FILE $TMUX_CONFIG_FILE

# link ~/.gitconfig
ln_file $PROJECT_GIT_CONFIG_FILE $GIT_CONFIG_FILE

# link ~/.vim
ln_dir $PROJECT_VIM_CONFIG_DIR $VIM_CONFIG_DIR

# link ~/.vimrc
ln_file $PROJECT_VIM_CONFIG_FILE $VIM_CONFIG_FILE

# ~/.vim link to ~/.config/nvim
ln_dir $VIM_CONFIG_DIR $NEOVIM_CONFIG_DIR

# ~/.vimrc link to ~/.vim/init.vim
ln_file $VIM_CONFIG_FILE $NEOVIM_CONFIG_FILE

# 安装 tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 安装 tmux 插件
~/.tmux/plugins/tpm/bin/install_plugins

# 配置 powerline 主题
ln_dir ~/.dotfiles/.config/powerline ~/.config/powerline
