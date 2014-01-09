# built-in .bashrc had this. Checks that the prompt is interactive.
[[ "$-" != *i* ]] && return

# I have some Haskell packages and programs installed on my laptop.
# They need their install location added to the PATH to work.
[[ -d  ~/.cabal/bin ]] && export PATH=~/.cabal/bin:$PATH

# Android SDK is installed at ~/android/sdk and ~/android/eclipse
[[ -d ~/android/sdk/platform-tools ]] && export PATH=~/android/sdk/platform-tools:$PATH
if [ -d ~/android/sdk/tools ]; then
    export PATH=~/android/sdk/tools:$PATH;
    export ANDROID_HOME=~/android/sdk
fi
[[ -d ~/android/eclipse ]] && export PATH=~/android/eclipse:$PATH

# CSCI 5161
[[ -d ~/compilers/scripts ]] && export PATH=~/compilers/scripts:$PATH

# Heroku
[[ -d /usr/local/heroku/bin ]] && export PATH=/usr/local/heroku/bin:$PATH

[[ -d ~/.gem/ruby ]] && export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH

###############################################################
##            Some preliminary environment setup.            ##
###############################################################

# Environment variables which can be useful
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
# On my personal (Linux) machines, alias ack to ack-grep,
# and make the prompt green
elif [ "$(whoami)" == "mike" ]; then
    command -v ack >/dev/null 2>&1 || alias ack=ack-grep
    GREEN='\[\033[1;32m\]'
    export PS1="\n${GREEN}\u@\h:\w\n\$ ${ENDCOLOR}"
    alias sml='rlwrap sml'
# On my work computer, set up some appropriate aliases,
elif [ "$(whoami)" == "mwadsten" ]; then
    CYAN='\[\033[1;36m\]'
    export PS1="\n${CYAN}\u@\h:\w\n\$ ${ENDCOLOR}"
    # Used to alias 'python' to Windows python. I don't like that anymore.
    # -i to get interactive prompt, -E to ignore PYTHON* environment variables
    alias py='/cygdrive/c/Python/2_6/python -iE'
    #alias cython='/usr/bin/python'
fi

# If I'm running Arch (most likely a VM), there are some things
# which must be fixed, chief among them being that many python-related
# programs have '2' appended to their names. These are my workarounds.
if [ "$(uname -mrs | sed 's/.*-\(arch\).*/\L\1/i')" == "arch" ]; then
    alias virtualenv=virtualenv2
    #alias pip=pip2

    # This is essentially doing a conditional alias of `pip`, to ensure that,
    # if running in a virtual environment, the `pip` executable for the
    # virtualenv is used; and if outside a virtual environment, the global pip
    # install (if installed as pip2) is used; or else, an error message is
    # displayed.
    pip() {
        if [ "$VIRTUAL_ENV" == "" ]; then
            # Not inside virtualenv environment - need to run pip2 if possible
            if [ command -v pip2 > /dev/null 2>&1 ]; then
                command pip2 $@
            else
                echo -e "\e[0;31mpip was not found. Did you mean to enter a virtual environment first?\e[0m"
                return 100
            fi
        else
            command pip $@
        fi
    }
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
log() { if [ "$1" == "" ]; then set -- "${@:0}" 10 "${@:2:3:4:5}"; fi; git log --decorate -$@ ;}
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
        return 100
    fi
}

# My fun little wrapper to enter Python virtual environments
# which I may have set up.
source ~/.venv

# don't put duplicate lines in history
HISTCONTROL=ignoredups:ignorespace

complete -cf sudo

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh # This loads NVM

sar() {
    original=$1
    replace=$2
    expr="'s/$original/$replace/g'"
    ack $original && (ack $original -l | xargs -p -n1 sed -i -e $expr)
}

POWERLINE_SHELL_FILE=~/.customizations/powerline-shell.py
function _update_ps1() {
    export PS1="$($POWERLINE_SHELL_FILE --mode=compatible) "
}

[[ -f $POWERLINE_SHELL_FILE ]] && export PROMPT_COMMAND="_update_ps1"

# Convenient way to run a command in the background and redirect its outputs to
# files. Example:
bgmagic() {
    if [ $# -le 2 ] ; then
        echo "Usage: $FUNCNAME <output-file> <command-with-arguments>"
        return 100
    fi
    OUTFILE=$1
    shift
    $@ 2> "$OUTFILE-error" > $OUTFILE &
}
