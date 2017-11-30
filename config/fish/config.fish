# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

set fish_greeting (set_color brown)-- (whoami)@(hostname) --(set_color normal)

alias weather "curl 'wttr.in?m'"

set PATH (cope_path) $PATH

alias less 'less -R'
#alias chromium 'chromium --proxy-server=localhost:8118'

set -x LC_ALL 'en_US.UTF-8'
set -x LANG 'en_US.UTF-8'

# dirty hack because if these variables are not set before we source the keychain config, it fails
set -x SSH_AUTH_SOCK ''
set -x SSH_AGENT_PID ''
set -x SHELL /usr/bin/fish
keychain --eval -Q --quiet | source

alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias ....... 'cd ../../../../../..'
alias ........ 'cd ../../../../../../..'
alias ......... 'cd ../../../../../../../..'
alias .......... 'cd ../../../../../../../../..'
alias ........... 'cd ../../../../../../../../../..'
alias ............ 'cd ../../../../../../../../../../..'
alias ............. 'cd ../../../../../../../../../../../..'
alias .............. 'cd ../../../../../../../../../../../../..'

set -x MOZ_USE_OMTC 1

alias chromium 'chromium --force-device-scale-factor=1'

setfont sun12x22 2>/dev/null

set -x XKB_DEFAULT_LAYOUT us
set -x XKB_DEFAULT_VARIANT colemak
set -x WLC_REPEAT_DELAY 200
set -x WLC_REPEAT_RATE 40

## start X at login
#if status --is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
#        exec startx -- -keeptty
#    end
#end

if status --is-interactive
    eval sh ~/dotfiles/base16-shell/base16-tomorrow.dark.sh
    #echo -n -e '\033]4;16;red\007'

    # set background color to transparent again
    printf "\033]11;rgba:1110/1110/1110/dddd\007"
end

alias vim nvim

# from https://github.com/iamruinous/plugin-powerline with some fixes
function init -a path --on-event init_powerline
  if type -q powerline-daemon
    powerline-daemon -q
  end

  set -q POWERLINE_PACKAGE_DIR; or set -gx POWERLINE_PACKAGE_DIR (pip show powerline-status 2>/dev/null | grep Location | awk '{ print $2 }')
  set fish_function_path $fish_function_path "$POWERLINE_PACKAGE_DIR/powerline/bindings/fish"

  if type -q powerline-setup
    powerline-setup
  else
    echo "Please install powerline"
  end
end
# customize in /home/v/.config/powerline/themes/shell/custom.json
#init

set -x GDK_SCALE 1
set -x GDK_DPI_SCALE 1
set -x QT_AUTO_SCREEN_SCALE_FACTOR 1

#set -x GDK_SCALE 2
#set -x GDK_DPI_SCALE 1
#set -x QT_AUTO_SCREEN_SCALE_FACTOR 1

set -x DTR_HOST 172.17.0.1

set -x LIBVIRT_DEFAULT_URI qemu:///system

set -x XKB_DEFAULT_LAYOUT us,us
set -x XKB_DEFAULT_VARIANT colemak,intl
set -x XKB_DEFAULT_OPTIONS grp:alt_shift_toggle

#alt-intl
#altgr-intl
#chr
#colemak
#dvorak
#dvorak-alt-intl
#dvorak-classic
#dvorak-intl
#dvorak-l
#dvorak-r
#dvp
#euro
#hbs
#intl
#mac
#olpc2
#rus
#workman
#workman-intl

set -x WLC_REPEAT_DELAY 200
set -x WLC_REPEAT_RATE 30
