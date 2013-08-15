#!/usr/bin/fish
set dotfiles ~/dev/dotfiles
rm ~/.vim
ln -s $dotfiles/.vim ~/.vim
rm ~/.if
ln -s $dotfiles/.if ~/.if
rm ~/.gitconfig
ln -s $dotfiles/.gitconfig ~/.gitconfig
rm ~/.remap_caps_lock
ln -s $dotfiles/.remap_caps_lock ~/.remap_caps_lock
rm ~/.vimrc
ln -s $dotfiles/.vimrc ~/.vimrc
rm ~/.xmonad/xmonad.hs
ln -s $dotfiles/.xmonad/xmonad.hs ~/.xmonad/xmonad.hs
rm ~/.config/fish/functions
ln -s $dotfiles/.config/fish/functions ~/.config/fish/functions
rm ~/.config/fish/config.fish
ln -s $dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
echo OK
