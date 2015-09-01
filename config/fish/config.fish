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

set fish_greeting (host -t txt istheinternetonfire.com | cut -f 2 -d '"')

set PATH (cope_path) /home/v/work/moz-git-tools /opt/android-sdk/platform-tools /home/v/work/b2g-hamachi/B2G/tools/update-tools/bin/linux-x86 /opt/sunbird /opt/play /home/v/idea-IU-141.1532.4/bin /usr/local/heroku/bin $PATH /home/v/.gem/ruby/2.1.0/bin/ /opt/jdk1.6.0_45/bin /home/v/work/b2g-hamachi/B2G/prebuilt/linux-x86/toolchain/arm-eabi-4.3.1/bin/ /home/v/Downloads/android-sdk-linux/platform-tools /home/v/.gem/ruby/2.1.0/bin /usr/local/bin/

set PATH $PATH (ruby -rubygems -e "puts Gem.user_dir")/bin

set PATH $PATH ~/go/bin
set PATH $PATH ~/.cabal/bin/
set PATH $PATH /usr/bin/vendor_perl/

# fix IDEA
set PATH /usr/lib/jvm/default/bin $PATH ~/go/bin

#source /home/v/.rvm/scripts/rvm

set -x GOPATH ~/go

alias less 'less -R'
#alias chromium 'chromium --proxy-server=localhost:8118'

set -x LC_ALL 'en_CA.UTF-8'
set -x LANG 'en_CA.UTF-8'

# dirty hack because if these variables are not set before we source the keychain config, it fails
set -x SSH_AUTH_SOCK ''
set -x SSH_AGENT_PID ''
keychain --eval -Q --quiet | source



set -x EMSCRIPTEN "/usr/lib/emscripten"
set -x EMSCRIPTEN_FASTCOMP "/usr/lib/emscripten-fastcomp"

# add to path
set -x PATH $PATH $EMSCRIPTEN

function fuck
    eval (thefuck $history[1])
end

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

set -x PATH $PATH /usr/bin/core_perl/

alias chromium 'chromium --force-device-scale-factor=1'
