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

# why the fuck is the path not set when ssh'd in or in a terminal???
#set PATH $PATH /run/current-system/sw/bin /run/current-system/sw/sbin

set fish_greeting (set_color brown)-- (whoami)@(hostname) --(set_color normal)

alias weather "curl 'wttr.in?m'"

set PATH $PATH ~/bin
set PATH (cope_path) $PATH

# fix IDEA
#set PATH /usr/lib/jvm/default/bin $PATH ~/go/bin

#set PATH $PATH /home/v/dev/colors/node_modules/.bin/

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
set -x SHELL /usr/bin/fish
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

# docker stuff
set PATH /home/v/docker $PATH


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

alias compose docker-compose

if status --is-interactive
    eval sh ~/dotfiles/base16-shell/base16-tomorrow.dark.sh
    #echo -n -e '\033]4;16;red\007'

    # set background color to transparent again
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

alias tf 'docker run -it -e TF_LOG -u (id -u):(id -g) --rm -v {$SSH_AUTH_SOCK}:{$SSH_AUTH_SOCK} -e SSH_AUTH_SOCK -v (pwd):/config -w /config hashicorp/terraform'
alias tf-graph 'tf graph | dot -Tpng | feh -'

alias dtr-tf 'docker run -it -e TF_LOG -u (id -u):(id -g) --rm -v {$SSH_AUTH_SOCK}:{$SSH_AUTH_SOCK} -e SSH_AUTH_SOCK -v (pwd):/config -w /config --entrypoint terraform dtr-internal.caas.docker.io/caas/dtr-nasa'

alias pack 'docker run -u (id -u):(id -g) --rm -it -v (pwd):/config -w /config hashicorp/packer'

set -x UCP_PASSWORD (cat ~/secrets/ucp_password.txt)
set -x ENZI_ADMIN_PASSWORD $UCP_PASSWORD

function etcdctl
  docker run --rm -v dtr-ca-$argv[1]:/ca --net dtr-br -it --entrypoint /etcdctl docker/dtr-etcd:v2.2.4 --endpoint https://dtr-etcd-$argv[1].dtr-br:2379 --ca-file /ca/etcd/cert.pem --key-file /ca/etcd-client/key.pem --cert-file /ca/etcd-client/cert.pem $argv[2..-1]
end

#alias dtr 'docker run -it --rm dtr-internal.caas.docker.io/caas/dtr'
#alias dtr-nontty 'docker run -i --rm dtr-internal.caas.docker.io/caas/dtr'
#alias dtr-upgrade 'dtr upgrade --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls'
## TODO: add --dtr-cert $DTR_CERT --dtr-key $DTR_KEY --dtr-ca $DTR_CERT when
## these flags become mainstream enough
#alias dtr-install 'dtr install --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1 --replica-id 000000000000 --debug --dtr-cert $DTR_CERT --dtr-key $DTR_KEY --dtr-ca $DTR_CERT'
#alias dtr-backup 'dtr-nontty backup --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --existing-replica-id 000000000000'
#alias dtr-restore 'dtr-nontty restore --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1 --replica-id 000000000001'
#alias dtr-reconfigure 'dtr reconfigure --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --existing-replica-id 000000000000'
#alias dtr-join 'dtr join --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-url http://172.17.0.1:444 --ucp-insecure-tls --existing-replica-id 000000000000'
#alias dtr-remove 'dtr remove --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-url http://172.17.0.1:444 --ucp-insecure-tls'

alias dtr-prod 'docker run -it --rm docker/dtr'
alias dtr-prod-install 'dtr-prod install --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1'

#alias dtr-clean "docker service ls | grep dtr- | awk '{print \$2}' | xargs docker service rm; docker ps -a | grep 'dtr\|dind\|docker:1.12.5\|dockerhubenterprise\|minio' | grep -v enzi | awk '{print \$1}' | xargs docker rm -f; docker volume ls | grep dtr | awk '{print \$2}' | xargs docker volume rm; docker network rm dtr-ol; docker network ls | grep dtr-br | awk '{print \$2}' | xargs docker network rm"

alias dtr-cluster-3 "dtr-clean; dtr-install --replica-id 000000000000; dtr-join --replica-http-port 2001 --replica-https-port 3001 --existing-replica-id 000000000000; and dtr-join --replica-http-port 2002 --replica-https-port 3002 --existing-replica-id 000000000000"


#alias dtr-install-2.0 'docker run -it --rm docker/dtr:2.0.4 install --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1'
#alias dtr-install-2.1 'docker run -it --rm docker/dtr:2.1.4 install --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1'
#alias dtr-install-2.2 'docker run -it --rm docker/dtr:2.2.0 install --ucp-url 172.17.0.1:444 --ucp-username admin --ucp-password $UCP_PASSWORD --ucp-insecure-tls --dtr-external-url 172.17.0.1  --dtr-cert $DTR_CERT --dtr-key $DTR_KEY --dtr-ca $DTR_CERT'


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

set -x REGISTRY_USERNAME viktorstanchev
set -x REGISTRY_PASSWORD (cat ~/secrets/registry_password.txt)
set -x DOGFOOD_USERNAME admin
set -x DOGFOOD_PASSWORD (cat ~/secrets/dogfood_password.txt)

begin
    set -l IFS
    set DTR_CERT (cat ~/docker/dtr/cert/cert.pem)
    set DTR_KEY (cat ~/docker/dtr/cert/key.pem)
end

alias ucp2-tp2 'docker run --rm -it --name ucp -e REGISTRY_USERNAME -e REGISTRY_PASSWORD -v /var/run/docker.sock:/var/run/docker.sock dockerorcadev/ucp:2.1.0-tp2'
alias ucp2-tp2-install 'ucp2-tp2 install --admin-password $UCP_PASSWORD --host-address 172.17.0.1 --controller-port 444 --san 172.17.0.1 --enable-profiling --image-version dev:'

alias ucp2-beta 'docker run --rm -it --name ucp -e REGISTRY_USERNAME -e REGISTRY_PASSWORD -v /var/run/docker.sock:/var/run/docker.sock docker/ucp:2.1.0-beta1'
alias ucp2-beta-install 'ucp2-beta install --admin-password $UCP_PASSWORD --host-address 172.17.0.1 --controller-port 444 --san 172.17.0.1 --enable-profiling'

#alias ucp2 'docker run --rm -it --name ucp -e REGISTRY_USERNAME -e REGISTRY_PASSWORD -v /var/run/docker.sock:/var/run/docker.sock docker/ucp'
#alias ucp2-install 'ucp2 install --admin-password $UCP_PASSWORD --host-address 172.17.0.1 --controller-port 444 --san 172.17.0.1'
#  --image-version dev:

alias ucp-derp-install 'docker run --rm -it --name ucp -v /var/run/docker.sock:/var/run/docker.sock dockerorcadev/ucp:2.0.0-c51581d install --admin-password $UCP_PASSWORD --host-address 172.17.0.1 --controller-port 444 --san 172.17.0.1 --image-version dev:'


alias dind-make 'make DOCKER_INCREMENTAL_BINARY=true'
alias dind-bind 'docker run --rm -it --privileged --name dind -v (pwd)/bundles/latest/binary-daemon/:/bin2 -v (pwd)/bundles/latest/binary-client/:/bin3 -e PATH=/bin2:/bin3:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin docker:dind --debug'
alias dind-bind-server 'docker run --rm -it --privileged --name dind -v (pwd)/bundles/latest/binary-daemon/:/bin2 -e PATH=/bin2:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin docker:dind --debug'


# usage: run-dind 1.12.2-cs2 dind1
function run-dind
    docker run -d --privileged --name $argv[2] -v /var/lib/docker/image/overlay2:/var/lib/docker/image/overlay2 -v /var/lib/docker/overlay2:/var/lib/docker/overlay2 -v /home/v/docker/docker-$argv[2]:/bin2 -e PATH=/bin2:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin docker:dind --debug -s overlay2
end

# blah. this uses a beta license TODO
# usage: ucp-dind-install dind1 172.20.0.2 2.0.0-beta4
function ucp-dind-install
# -v /home/v/dev/dtr/dhe-deploy/src/dtr/nasa/terraform/license-beta.lic:/config/docker_subscription.lic
    docker exec -it $argv[1] docker run --rm -it --name ucp  -v /var/run/docker.sock:/var/run/docker.sock docker/ucp:$argv[3] install --admin-username admin --admin-password notpassword --san $argv[2] --san $argv[1] --host-address eth0 --controller-port 444
end

# note hardcoded password
# usage: bundle-exec 172.17.0.1 node ls
function bundle-exec
    set -l bundledir (mktemp -d -t bundle-XXXXX)
    pushd $bundledir
    curl -s 'https://'$argv[1]'/api/clientbundle' -H 'authorization: Bearer '(curl -s 'https://'$argv[1]'/auth/login' -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' --data-binary "{\"username\":\"admin\",\"password\":\"notpassword\"}" --insecure  | jq -r '.auth_token') -H 'accept: application/json, text/plain, */*' --insecure > bundle.zip
    unzip -qq -o bundle.zip
    bash -c "eval \$(<env.sh); docker $argv[2..-1]"
    popd
    rm -r $bundledir
end

# same as bundle exec but with the right password
function bundle-exec2
    set -l bundledir (mktemp -d -t bundle-XXXXX)
    pushd $bundledir
    curl -s 'https://'$argv[1]'/api/clientbundle' -H 'authorization: Bearer '(curl -s 'https://'$argv[1]'/auth/login' -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' --data-binary "{\"username\":\"admin\",\"password\":\"$UCP_PASSWORD\"}" --insecure  | jq -r '.auth_token') -H 'accept: application/json, text/plain, */*' --insecure > bundle.zip
    unzip -qq -o bundle.zip
    bash -c "eval \$(<env.sh); docker $argv[2..-1]"
    popd
    rm -r $bundledir
end

# TODO: add cluster prefix parameter; also TODO: make this work for non-public, non-beta ucp
# versions
# usage: magic-cluster 1.12.2-cs2 2.0.0-beta4 docker/dtr:2.0.4
function magic-cluster
    set -l docker_version $argv[1]
    set -l ucp_version $argv[2]
    set -l dtr_version $argv[3]

    docker network create ucpnet; or true

    docker rm -f dind1; or true
    docker rm -f dind2; or true
    docker rm -f dind3; or true

    run-dind $docker_version dind1
    run-dind $docker_version dind2
    run-dind $docker_version dind3

    set -l ip1 (docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind1)

    ucp-dind-install dind1 $ip1 $ucp_version
    set -l token (docker exec dind1 docker swarm join-token worker -q)
    docker exec -it dind2 docker swarm join --token $token $ip1:2377
    docker exec -it dind3 docker swarm join --token $token $ip1:2377

    magic-health 3

    magic-install $dtr_version
end

# TODO: add cluster prefix parameter; also TODO: make this work for non-public, non-beta ucp
# versions
# usage: magic-ucp 1.12.2-cs2 2.0.0-beta4
function magic-ucp
    set -l docker_version $argv[1]
    set -l ucp_version $argv[2]

    docker network create ucpnet; or true

    docker rm -f dind1; or true

    run-dind $docker_version dind1

    set -l ip1 (docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind1)

    ucp-dind-install dind1 $ip1 $ucp_version

    magic-health 1
end


# TODO: add cluster prefix parameter; also TODO: make this work for non-public, non-beta ucp
# versions
# usage: magic-machine 1.12.2-cs2 2.0.0-beta4 docker/dtr:2.0.4
function magic-machine
    set -l docker_version $argv[1]
    set -l ucp_version $argv[2]
    set -l dtr_version $argv[3]

    magic-ucp $docker_version $ucp_version

    set -l ip1 (docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind1)
    docker exec -it dind1 docker run --rm -it $dtr_version install --replica-id 000000000000 --ucp-url $ip1:444 --ucp-username admin --ucp-password notpassword --dtr-external-url $ip1 --ucp-insecure-tls
end

# usage: magic-health 3
function magic-health
    set -l num_target $argv[1]

    set -l ip1 (docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind1)
    set -l ATTEMPT 0
    set -l IS_OK no
    while [ $IS_OK != OK ]
        set -l num_healthy (bundle-exec $ip1 node ls | grep Ready | wc -l)
        if [ $num_healthy = $num_target ]
            set IS_OK OK
        end
        set -l ATTEMPT (math $ATTEMPT+1)
        echo $ATTEMPT
        sleep 1
    end

    set -l ATTEMPT 0
    set -l IS_OK no
    while [ $IS_OK != OK ]
        set -l maybe_success (bundle-exec $ip1 run --rm alpine echo success)
        if [ $maybe_success = success ]
            set IS_OK OK
        end
        set -l ATTEMPT (math $ATTEMPT+1)
        echo $ATTEMPT
        sleep 1
    end
end

# usage: magic-grow 1.12.2-cs2 dind3
function magic-grow
    set -l docker_version $argv[1]
    set -l name $argv[2]

    echo run-dind $docker_version $name
    run-dind $docker_version $name
    set -l ip1 (docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind1)

    set -l token (docker exec dind1 docker swarm join-token worker -q)
    docker exec -it $name docker swarm join --token $token $ip1:2377

    # TODO: make dynamic?
    magic-health 3
end

# usage: magic-install docker/dtr:2.2.0
function magic-install
    set -l dtr_version $argv[1]

    set -l ip1 (docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dind1)
    set -l id1 (docker inspect --format '{{range .NetworkSettings.Networks}}{{range .Aliases}}{{.}}{{end}}{{end}}' dind1)
    docker exec -it dind1 docker run --rm -it $dtr_version install --replica-id 000000000000 --ucp-node $id1 --ucp-url $ip1 --ucp-username admin --ucp-password notpassword --dtr-external-url $ip1:444 --replica-http-port 81 --replica-https-port 444 --ucp-insecure-tls
    docker exec -it dind1 docker run --rm -it $dtr_version join --existing-replica-id 000000000000 --ucp-url $ip1 --ucp-username admin --ucp-password notpassword --replica-http-port 81 --replica-https-port 444 --ucp-insecure-tls
    docker exec -it dind1 docker run --rm -it $dtr_version join --existing-replica-id 000000000000 --ucp-url $ip1 --ucp-username admin --ucp-password notpassword --replica-http-port 81 --replica-https-port 444 --ucp-insecure-tls
end

# usage: magic-clean-one dind1
function magic-clean-one
    docker exec -it $argv[1] sh -c "
        docker service ls | grep dtr- | awk '{print \$2}' | xargs docker service rm
        docker ps -a | grep dtr | grep -v enzi | awk '{print \$1}' | xargs docker rm -f
        docker volume ls | grep dtr | awk '{print \$2}' | xargs docker volume rm
        docker network rm dtr-ol
        docker network ls | grep dtr-br | awk '{print \$2}' | xargs docker network rm
    "
end

function magic-clean
    magic-clean-one dind1
    magic-clean-one dind2
    magic-clean-one dind3
end

# usage: magic-resurrect dind3
function magic-resurrect
    set -l root (docker inspect --format '{{ .GraphDriver.Data.UpperDir}}' $argv[1])
    sudo rm $root/var/run/docker.pid
end

# usage: ucp-pull-dev dockerorcadev/ucp:2.0.0-latest
function ucp-pull-dev
    docker pull $argv
    for i in (docker run --rm $argv images --list --image-version dev: ); docker pull $i; end
end

# usage: ucp-pull docker/ucp:2.0.0-beta4
function ucp-pull
    docker pull $argv
    for i in (docker run --rm $argv images --list ); docker pull $i; end
end

# usage: dtr-pull docker/dtr:2.0.4
function dtr-pull
    docker pull $argv
    for i in (docker run --rm $argv images ); docker pull $i; end
end

function trust-notary-443
    echo trusting $argv
    mkdir -p ~/.docker/tls/$argv; openssl s_client -showcerts -connect $argv 2>/dev/null < /dev/null | openssl x509 -outform PEM 2>/dev/null > ~/.docker/tls/$argv/ca.crt
end

function trust-notary
    echo trusting $argv
    mkdir -p ~/.docker/tls/$argv; openssl s_client -showcerts -connect $argv:443 2>/dev/null < /dev/null | openssl x509 -outform PEM 2>/dev/null > ~/.docker/tls/$argv/ca.crt
end

alias notary-clean 'rm -rf ~/.docker/trust'

alias trust-notary-local 'trust-notary 172.17.0.1'
alias trust-notary-local-443 'trust-notary-443 172.17.0.1:443'

function ucp-post
    curl 'https://'$argv[0]'/'$argv[1] -H 'authorization: Bearer '(curl 'https://'$argv[0]'/auth/login' -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' --data-binary "{\"username\":\"admin\",\"password\":\"$UCP_PASSWORD\"}" --insecure  | jq -r '.auth_token')  -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' -d $argv[2] --insecure
end

alias bundle-local 'ucp-bundle 172.17.0.1:444'

function ucp-bundle
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

#alias nuke 'docker swarm leave --force; docker ps -aq | xargs docker rm -f; docker volume ls -q | xargs docker volume rm'


set -x GDK_SCALE 1
set -x GDK_DPI_SCALE 1
set -x QT_AUTO_SCREEN_SCALE_FACTOR 1

#set -x GDK_SCALE 2
#set -x GDK_DPI_SCALE 1
#set -x QT_AUTO_SCREEN_SCALE_FACTOR 1

set -x DTR_HOST 172.17.0.1

source ~/caas-dotfiles/dtr/aliases.fish

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

set -x TESTKIT_AWS_SECURITY_GROUP everything-open
set -x TESTKIT_ENGINE ee-test-17.06

source ~/docker/docker-17.03.1-ce/completion/fish/docker.fish
