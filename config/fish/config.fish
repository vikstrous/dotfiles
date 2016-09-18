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

#  (cope_path)
#set PATH /home/v/work/moz-git-tools /opt/android-sdk/platform-tools /home/v/work/b2g-hamachi/B2G/tools/update-tools/bin/linux-x86 /opt/sunbird /opt/play /home/v/idea-IU-141.1532.4/bin /usr/local/heroku/bin $PATH /opt/jdk1.6.0_45/bin /home/v/work/b2g-hamachi/B2G/prebuilt/linux-x86/toolchain/arm-eabi-4.3.1/bin/ /home/v/Downloads/android-sdk-linux/platform-tools /home/v/.gem/ruby/2.1.0/bin /usr/local/bin/

#set PATH $PATH (ruby -rubygems -e "puts Gem.user_dir")/bin

#set PATH $PATH ~/go/bin
#set PATH $PATH ~/bin
#set PATH $PATH ~/.cabal/bin/
#set PATH $PATH /usr/bin/vendor_perl/

# fix IDEA
#set PATH /usr/lib/jvm/default/bin $PATH ~/go/bin

#source /home/v/.rvm/scripts/rvm

set -x GOPATH ~/dev/dtr/go
set -x GOBIN ~/dev/dtr/go/bin
set -x PATH $PATH ~/dev/dtr/go/bin

alias less 'less -R'
#alias chromium 'chromium --proxy-server=localhost:8118'

set -x LC_ALL 'en_US.UTF-8'
set -x LANG 'en_US.UTF-8'

# dirty hack because if these variables are not set before we source the keychain config, it fails
set -x SSH_AUTH_SOCK ''
set -x SSH_AGENT_PID ''
keychain --eval -Q --quiet | source



#set -x EMSCRIPTEN "/usr/lib/emscripten"
#set -x EMSCRIPTEN_FASTCOMP "/usr/lib/emscripten-fastcomp"

# add to path
#set -x PATH $PATH $EMSCRIPTEN

#function fuck
#    eval (thefuck $history[1])
#end

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

#set -x PATH $PATH /usr/bin/core_perl/

set -x MOZ_USE_OMTC 1

alias chromium 'chromium --force-device-scale-factor=2'

set -x GDK_SCALE 2
set -x GDK_DPI_SCALE 0.5
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

alias compose docker-compose

eval sh ~/dotfiles/base16-shell/base16-tomorrow.dark.sh
#echo -n -e '\033]4;16;red\007'

# set background color to transparent again
if status --is-interactive
    printf "\033]11;rgba:1110/1110/1110/dddd\007"
end



#set -x CSCOPE_DB ~/dev/linux/cscope.out
set -x GO15VENDOREXPERIMENT 1

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

alias tf 'docker run -u (id -u):(id -g) --rm -it -v /home/v/.ssh/id_rsa:/id_rsa -v (pwd):/config -w /config hashicorp/terraform'
alias tf-graph 'tf graph | dot -Tpng | feh -'

alias pack 'docker run -u (id -u):(id -g) --rm -it -v (pwd):/config -w /config hashicorp/packer'

set -x UCP_PASSWORD (cat ~/secrets/ucp_password.txt)

function etcdctl
  docker run --rm -v dtr-ca-$argv[1]:/ca --net dtr-br -it --entrypoint /etcdctl docker/dtr-etcd:v2.2.4 --endpoint https://dtr-etcd-$argv[1].dtr-br:2379 --ca-file /ca/etcd/cert.pem --key-file /ca/etcd-client/key.pem --cert-file /ca/etcd-client/cert.pem $argv[2..-1]
end

alias dtr 'docker run -it --rm dtr-internal.caas.docker.io/caas/dtr'
alias dtr-nontty 'docker run -i --rm dtr-internal.caas.docker.io/caas/dtr'
alias dtr-install 'dtr install --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1'
alias dtr-backup 'dtr-nontty backup --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls'
alias dtr-restore 'dtr-nontty restore --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1'
alias dtr-reconfigure 'dtr reconfigure --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls'
alias dtr-join 'dtr join --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-url http://172.17.0.1:444 --ucp-insecure-tls'
alias dtr-remove 'dtr remove --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-url http://172.17.0.1:444 --ucp-insecure-tls'

alias dtr-clean "docker service ls | grep dtr- | awk '{print \$2}' | xargs docker service rm; docker ps -a | grep dtr | grep -v enzi | awk '{print \$1}' | xargs docker rm -f; docker volume ls | grep dtr | awk '{print \$2}' | xargs docker volume rm; docker network rm dtr-ol dtr-br"

alias dtr3 'docker run --rm -it dtr-internal.caas.docker.io/caas/dtr-swarmifier:latest'
alias dtr3-install 'dtr3 --debug install --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1'

function dtr-db-proxy
    docker create -it \
        --net dtr-br \
        --name dtr-db-proxy \
        -v dtr-ca-$argv:/ca \
        -p 8080:8080 \
        jlhawn/rethinkdb-tls \
            proxy \
            --bind all \
            --driver-tls \
            --driver-tls-key /ca/rethink/key.pem \
            --driver-tls-cert /ca/rethink/cert.pem \
            --driver-tls-ca /ca/rethink/cert.pem \
            --cluster-tls \
            --cluster-tls-key /ca/rethink/key.pem \
            --cluster-tls-cert /ca/rethink/cert.pem \
            --cluster-tls-ca /ca/rethink/cert.pem \
            --join dtr-rethinkdb-$argv.dtr-ol
    docker network connect dtr-ol dtr-db-proxy
    docker start dtr-db-proxy
    docker attach dtr-db-proxy
end

alias machine 'docker-machine'
alias jenkup 'machine create -d amazonec2 --amazonec2-ami ami-7f675e4f --amazonec2-instance-type m3.medium --amazonec2-region us-west-2 --amazonec2-root-size 30 --engine-storage-driver aufs'

alias dicker 'grc docker'

alias ucp1 'docker run --rm -it --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp:1.1.3'
alias ucp1-install 'ucp1 install --admin-password $UCP_PASSWORD --host-address 172.17.0.1 --controller-port 444 --fresh-install'

alias ucp2 'docker run --rm -it --name ucp -v /var/run/docker.sock:/var/run/docker.sock dockerorcadev/ucp:2.0.0-latest'
alias ucp2-install 'ucp2 install --admin-password $UCP_PASSWORD --host-address 172.17.0.1 --controller-port 444 --san 172.17.0.1 --image-version dev:'

function ucp-pull-dev
    for i in (docker run --rm $argv images --list --image-version dev: ); docker pull $i; end
end

alias trust-notary-local 'trust_notary 172.17.0.1'

function trust-notary
    mkdir -p ~/.docker/tls/$argv; openssl s_client -showcerts -connect $argv:443 2>/dev/null < /dev/null | openssl x509 -outform PEM 2>/dev/null > ~/.docker/tls/$argv/ca.crt
end

function ucp-post
    curl 'https://'$argv[0]'/'$argv[1] -H 'authorization: Bearer '(curl 'https://'$argv[0]'/auth/login' -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' --data-binary "{\"username\":\"admin\",\"password\":\"$UCP_PASSWORD\"}" --insecure  | jq -r '.auth_token')  -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' -d $argv[2] --insecure
end

alias bundle-local 'bundle 172.17.0.1:444'

function bundle
    mkdir bundle-$argv
    curl 'https://'$argv'/api/clientbundle' -H 'authorization: Bearer '(curl 'https://'$argv'/auth/login' -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' --data-binary "{\"username\":\"admin\",\"password\":\"$UCP_PASSWORD\"}" --insecure  | jq -r '.auth_token') -H 'accept: application/json, text/plain, */*' --insecure > bundle-$argv/bundle.zip
    cd bundle-$argv
    unzip -o bundle.zip
    bash --rcfile env.sh
end

function logs
    docker logs $argv 2>&1 | grep '^{' | jq .
end

function errlogs
    docker logs $argv 2>&1 | grep error | grep '^{' | jq .
end

alias nuke 'docker swarm leave --force; docker ps -aq | xargs docker rm -f; docker volume ls -q | xargs docker volume rm'
