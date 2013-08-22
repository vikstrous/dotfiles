#!/usr/bin/fish
set dotfiles ~/dotfiles

set array '.vim' '.if' '.Xdefaults' '.xinitrc' '.gitconfig' '.remap_caps_lock' '.vimrc' '.xmonad/xmonad.hs' '.xmobarrc' '.config/fish/functions' '.config/fish/config.fish'
for i in $array
  rm ~/$i
  ln -s $dotfiles/$i ~/$i
end

echo OK
