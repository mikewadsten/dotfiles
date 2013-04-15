# built-in .bashrc had this. Checks that the prompt is interactive.
[[ "$-" != *i* ]] && return

# I have some Haskell packages and programs installed on my laptop.
# They need their install location added to the PATH to work.
[[ -d  ~/.cabal/bin ]] && export PATH=~/.cabal/bin:$PATH

# Android SDK is installed at ~/android/sdk and ~/android/eclipse
[[ -d ~/android/sdk/platform-tools ]] && export PATH=~/android/sdk/platform-tools:$PATH
[[ -d ~/android/sdk/tools ]] && export PATH=~/android/sdk/tools:$PATH
[[ -d ~/android/eclipse ]] && export PATH=~/android/eclipse:$PATH

# CSCI 5161
[[ -d ~/compilers/scripts ]] && export PATH=~/compilers/scripts:$PATH

###############################################################
##            Some preliminary environment setup.            ##
###############################################################

# Environment variables which can be useful
export CSESVN=https://www-users.cselabs.umn.edu/svn/F12C3081
export PYTHONSTARTUP=~/.pyrc

# Stylize the bash prompt and set up 'ack' depending on the machine.

ENDCOLOR='\[\033[0m\]'
# On CSE labs machines, alias ack to standalone version of ack,
# and make the prompt red
if [ "$(whoami)" == "wadst007" ]; then
    alias ack='~/bin/ack'
    RED='\[\033[1;31m\]'
    export PS1="\n${RED}\u@\h:\w\n\$ ${ENDCOLOR}"
    alias sml='rlwrap sml'
fi
# On my personal (Linux) machines, alias ack to ack-grep,
# and make the prompt green
if [ "$(whoami)" == "mike" ]; then
    alias ack=ack-grep
    GREEN='\[\033[1;32m\]'
    export PS1="\n${GREEN}\u@\h:\w\n\$ ${ENDCOLOR}"
    alias sml='rlwrap sml'
fi
# On my work computer, set up some appropriate aliases,
if [ "$(whoami)" == "mwadsten" ]; then
    CYAN='\[\033[1;36m\]'
    export PS1="\n${CYAN}\u@\h:\w\n\$ ${ENDCOLOR}"
    # Used to alias 'python' to Windows python. I don't like that anymore.
    alias py='/cygdrive/c/Python/2_6/python'
    #alias cython='/usr/bin/python'
fi

###############################################################
##           Various aliases that make life easier.          ##
###############################################################

alias ls='ls -hF --color=tty --group-directories-first'
alias ll='ls -lF --group-directories-first'
alias la='ls -AF --group-directories-first'
alias l='ls -C'
alias ~='cd ~'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# A rather uninteresting alias.
alias copy=cp

# I've gotten too used to these aliases to give them up.
alias push='git push'
alias pull='git pull'

# Will most likely be moved to gitconfig aliases later on.
alias dw='git diff --color --word-diff'
alias sincetag='git shortlog `git describe --abbrev=0 --tags`..HEAD'

###############################################################
##           Custom functions that make life easier.         ##
###############################################################

cd() { builtin cd $@ && ls; }

# These don't save much more typing that my git aliases do...
log() { git log --decorate -$@ ;}
slog() { git shortlog -$@ ;}

# This is the same as 'cd -', isn't it?
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

# My fun little wrapper to enter Python virtual environments
# which I may have set up.
source ~/.venv
