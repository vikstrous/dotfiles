export PS1="\[$(tput setaf 1)\]\$? \[$(tput setaf 6)\][\t] \[$(tput setaf 3)\]\w\n\[$(tput setaf 2)\]>\[$(tput sgr0)\] "
alias files="find . -type f | grep -v '/\\.svn|/config|/build|/\\.gradle|/\\.git'"
alias hextostr="perl -pe 's/(..)/chr(hex($1))/ge'"
function savealias() { echo "alias $1" >> ~/.bashrc && source ~/.bashrc; }
