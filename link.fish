#!/usr/bin/fish
set dotfiles ~/dev/dotfiles

set array '.vim' '.if' '.Xdefaults' '.xinitrc' '.gitconfig' '.remap_caps_lock' '.vimrc' '.xmonad/xmonad.hs' '.config/fish/functions' '.config/fish/config.fish'
for i in $array
  rm ~/$i
  ln -s $dotfiles/$i ~/$i
end

#rm ~/.vim
#ln -s $dotfiles/.vim ~/.vim
#rm ~/.if
#ln -s $dotfiles/.if ~/.if
#rm ~/.Xdefaults
#ln -s $dotfiles/.Xdefaults ~/.Xdefaults
#rm ~/.xinitrc
#ln -s $dotfiles/.xinitrc ~/.xinitrc
#rm ~/.gitconfig
#ln -s $dotfiles/.gitconfig ~/.gitconfig
#rm ~/.remap_caps_lock
#ln -s $dotfiles/.remap_caps_lock ~/.remap_caps_lock
#rm ~/.vimrc
#ln -s $dotfiles/.vimrc ~/.vimrc
#rm ~/.xmonad/xmonad.hs
#ln -s $dotfiles/.xmonad/xmonad.hs ~/.xmonad/xmonad.hs
#rm ~/.config/fish/functions
#ln -s $dotfiles/.config/fish/functions ~/.config/fish/functions
#rm ~/.config/fish/config.fish
#ln -s $dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
echo OK
