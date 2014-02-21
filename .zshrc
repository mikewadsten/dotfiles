# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

WORKON_HOME=$HOME/.envs

# Plugins
plugins=()

plugins+=(git)

# Python-related plugins
plugins+=(python pip virtualenv virtualenvwrapper)
# Node-related plugins
plugins+=(node npm coffee)

plugins+=(autojump)

UNAME=`uname`

if [[ $UNAME == 'Darwin' ]]; then
    plugins+=(osx brew gem)
fi

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/share/python:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$HOME/bin:/usr/local/bin:$PATH

function powerline_precmd() {
    export PS1="$(~/.customizations/powerline-shell.py --mode=patched --shell zsh $? 2>/dev/null) "
}
if [ x$DISPLAY != x ]; then
    function install_powerline_precmd() {
        for s in "${precmd_functions[@]}"; do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    install_powerline_precmd
fi

[[ -d /usr/local/heroku/bin ]] && export PATH=/usr/local/heroku/bin:$PATH
[[ -d $HOME/.gem/ruby/2.0.0/bin ]] && export PATH=$HOME/.gem/ruby/2.0.0/bin:$PATH

export LESS=-RFX

alias ls='ls -hF --color=tty --group-directories-first'
alias ll='ls -lF --group-directories-first'
alias la='ls -AF --group-directories-first'
alias ~-'cd ~'

cd() { builtin cd $@ && ls ;}

export SHELL=$(which zsh)
