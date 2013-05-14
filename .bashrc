export PS1="\[$(tput setaf 1)\]\$? \[$(tput setaf 6)\][\t] \[$(tput setaf 3)\]\w\n\[$(tput setaf 2)\]>\[$(tput sgr0)\] "
alias files='find . -type f | grep -v /\\.svn | grep -v /config | grep -v /build | grep -v /\\.gradle | grep -v /\\.git'
