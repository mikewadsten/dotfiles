[[ "$-" != *i* ]] && return

alias whence='type -a'                        # where, of a sort
alias ls='ls -hF --color=tty --group-directories-first'                 # classify files in colour
alias ll='ls -lF --group-directories-first'                              # long list
alias la='ls -AF --group-directories-first'                              # all but . and ..
alias l='ls -C'                              #
alias ~='cd ~'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias gcl='git clone'
alias gch='git checkout'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gpush='git push origin'
alias gpull='git pull origin'
alias gs='git status'
#alias s='git status --short'
#alias d='git diff --color'
alias dw='git diff --color --word-diff'
alias push='git push'
alias pull='git pull'
alias sincetag='git shortlog `git describe --abbrev=0 --tags`..HEAD'
cb() { git checkout $@ ;}
cd() { builtin cd $@ && ls; }

# REALLY? A function to print an error? Yeah...
_sderror() { echo "$1: Current directory has no version control!" ;}

# Alias 's' and 'd' to git-diff or svn-diff based on current directory

s() {
    # suppress stderr
    exec 2> /dev/null
    if git rev-parse
    then
        # Current directory is a git repository
        git status --short
    elif [[ -d "$PWD"/.svn ]]
    then
        # Current directory is under svn control
        svn status
    else
        _sderror $FUNCNAME
    fi
    # unsuppress stderr
    exec 2> /dev/tty
}

d() {
    # suppress stderr
    exec 2> /dev/null
    if git rev-parse
    then
        # Current directory is under git control
        git diff --color
    elif [[ -d "$PWD"/.svn ]]
    then
        # Current directory is under svn control
        svn diff
    else
        _sderror $FUNCNAME
    fi
    # unsuppress stderr
    exec 2> /dev/tty
}

# Wrap git-commit and svn-commit in commit command
commit() {
    # Suppress stderr
    exec 2> /dev/null
    if git rev-parse
    then
        # Current directory is under git control
        exec 2> /dev/tty # Unsuppress stderr
        git commit $@
    elif [[ -d "$PWD"/.svn ]]
    then
        # Current directory is under svn control
        exec 2> /dev/tty # Unsuppress stderr
        svn commit $@
    else
        _sderror $FUNCNAME
    fi
    # Unsuppress stderr
    exec 2> /dev/tty
}

ENDCOLOR='\[\033[0m\]'
# On CSE labs machines, alias ack to standalone version of ack,
# and make the prompt ]'d
if [ "$(whoami)" == "wadst007" ]; then
    alias ack='~/bin/ack'
    RED='\[\033[1;31m\]'
    export PS1="\n${RED}\u@\h:\w\n\$ ${ENDCOLOR}"
fi
# On my personal machines, alias ack to ack-grep, and make the prompt green
if [ "$(whoami)" == "mike" ]; then
    alias ack=ack-grep
    GREEN='\[\033[1;32m\]'
    export PS1="\n${GREEN}\u@\h:\w\n\$ ${ENDCOLOR}"
fi
# On my work computer, make the prompt cyan, set up some aliases
if [ "$(whoami)" == "mwadsten" ]; then
    CYAN='\[\033[1;36m\]'
    export PS1="\n${CYAN}\u@\h:\w\n\$ ${ENDCOLOR}"
    export FBOARDPATH=/cygdrive/c/HelloFreedom/
    alias python='/cygdrive/c/Python/2_6/python'
    alias cython='/usr/bin/python'
fi

alias copy=cp

log() { git log -$@ ;}
slog() { git shortlog -$@ ;}

back() { cd $OLDPWD ;}
# Uncompress depending on extension
# copied from Josh Davis (github.com/jdavis/cs-dotfiles/.bashrc)
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xvjf $@  ;;
            *.tar.gz)   tar xvzf $@  ;;
            *.bz2)      bunzip2 $@   ;;
            *.rar)      unrar x $@   ;;
            *.gz)       gunzip $@    ;;
            *.tar)      tar xvf $@   ;;
            *.tbz2)     tar xvjz $@  ;;
            *.tgz)      tar xvzf $@  ;;
            *.zip)      unzip $@     ;;
            *.Z)        uncompress $@;;
            *.7z)       7z x $@      ;;
            *)          echo "'$1' cannot be extracted via >$FUNCNAME<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

export CSESVN=https://www-users.cselabs.umn.edu/svn/F12C3081
