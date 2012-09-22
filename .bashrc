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

alias ack=ack-grep
alias copy=cp
#alias python='/cygdrive/c/Python/2_6/python'
#alias cython='/usr/bin/python'

log() { git log -$@ ;}
slog() { git shortlog -$@ ;}
export FBOARDPATH=/cygdrive/c/HelloFreedom/

back() { cd $OLDPWD ;}
# Uncompress depending on extension
# copied from Josh Davis (github.com/jdavis/cs-dotfiles/.bashrc)
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xvjf $1  ;;
            *.tar.gz)   tar xvzf $1  ;;
            *.bz2)      bunzip2 $1   ;;
            *.rar)      unrar x $1   ;;
            *.gz)       gunzip $1    ;;
            *.tar)      tar xvf $1   ;;
            *.tbz2)     tar xvjz $1  ;;
            *.tgz)      tar xvzf $1  ;;
            *.zip)      unzip $1     ;;
            *.Z)        uncompress $1;;
            *.7z)       7z x $1      ;;
            *)          echo "'$1' cannot be extracted via >$FUNCNAME<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
