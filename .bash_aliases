# My custom aliases

alias svnaddall='svn add $(svn st | awk '\''{print }'\'') 2>/dev/null'
alias svngunzip='gunzip $(svn st | grep "^\?.*\.gz" | awk '\''{print $2}'\'')'
alias svnstver='svn st | grep -v "^?"'
alias svnunver='svn rm --keep-local $1'
alias svncommit='svn commit -m \"$*\"'
alias svnstsw='svn st | grep ".py\$\|.sh\$"; echo "found all .py and .sh"'
alias svnst='svn st --depth=immediates'
alias diff='colordiff'
alias muxat='tmux attach -t $1'
