#!/usr/bin/fish
set dotfiles ~/dev/dotfiles
ln -s $dotfiles/.vim ~/.vim
ln -s $dotfiles/.if ~/.if
ln -s $dotfiles/.vimrc ~/.vimrc
ln -s $dotfiles/.config/fish/functions ~/.config/fish/functions
ln -s $dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
echo OK
