#!/usr/bin/fish
set dotfiles ~/dotfiles

set array '.vim' '.if' '.Xdefaults' '.gitconfig' '.remap_caps_lock' '.vimrc' '.xmonad/xmonad.hs' '.xmobarrc' '.config/fish/functions' '.config/fish/config.fish'
for i in $array
  rm ~/$i
  ln -s $dotfiles/$i ~/$i
end

sudo rm /etc/slim.conf
sudo ln -s $dotfiles/slim.conf /etc/slim.conf

echo OK
