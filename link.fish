#!/usr/bin/fish
set dotfiles ~/dotfiles

function setUpLinks
    set src $argv[1]
    set dst $argv[2]
    for i in $argv[3..-1]
        if test -e $dst/$i 
            # file exists
            if test -L $dst/$i 
                if test (readlink $dst/$i) != $src/$i
                    # link exists, but it's the wrong link
                    echo Please delete wrong link $dst/$i
                else
                    # it's already the right link!
                    set_color green
                    echo $dst/$i OK
                    set_color normal
                end
            else
                echo Please delete existing file/folder $dst/$i
            end
        else
            # file doesn't exist
            if test -L $dst/$i
                #dead link, we can delete it
                rm $dst/$i
            end
            if ln -s $src/$i $dst/$i
                # we created the link!
                set_color green
                echo $dst/$i OK
                set_color normal
            else
                set_color red
                echo $dst/$i NOT OK
                set_color normal
            end
        end
    end
end

setUpLinks $dotfiles/links ~ (ls links -A)

setUpLinks $dotfiles/config ~/.config 'fish/functions' 'fish/config.fish'

sudo rm /etc/slim.conf
sudo ln -s $dotfiles/configs/slim.conf /etc/slim.conf
