# Check for tmux existence
command -v tmux &> /dev/null

NO_AUTO_TMUX=1

if [[ ( -z $TMUX ) && ( -z $NO_AUTO_TMUX ) && ( $? -eq 0 ) ]]; then
    # No TMUX session yet -- decide which session to launch into.
    tmuxsess="remote"

    if [[  ( -z $SSH_TTY ) && ( -z $SSH_CLIENT ) ]]; then
        # Not running over SSH -- use local session instead!
        tmuxsess="local"
    fi

    echo "Using tmux session $tmuxsess"

    tmux has-session -t $tmuxsess &> /dev/null
    if [ $? -eq 0 ]; then
        echo "Attaching to session..."
        exec tmux attach-session -t $tmuxsess
    else
        echo "Creating session..."
        exec tmux new-session -s $tmuxsess
    fi
fi

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
#ZSH_THEME="agnoster"
ZSH_THEME="mikewadsten"

WORKON_HOME=$HOME/.envs

VIRTUALENVWRAPPER_PYTHON=$(which python2.7)
# Override on Mac with Homebrew-ed python
[[ -f /usr/local/bin/python ]] && export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python

# Plugins
plugins=()

plugins+=(git)

# Python-related plugins
plugins+=(python pip virtualenv virtualenvwrapper)
# Node-related plugins
plugins+=(node npm coffee)

# Autojump is broken for me sometimes :(
#plugins+=(autojump)

UNAME=`uname`

if [[ $UNAME == 'Darwin' ]]; then
    plugins+=(osx brew gem)
fi

command -v github >/dev/null 2>&1 && plugins+=(github)

# MUST BE LAST
plugins+=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/share/python:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$HOME/bin:/usr/local/bin:$PATH

function powerline_precmd() {
    if [[  ( -z $SSH_TTY ) && ( -z $SSH_CLIENT ) ]]; then
        # Not running over SSH -- use patched
        MODE="--mode=patched"
    else
        MODE="--mode=flat"
    fi
    export PS1="$(~/.customizations/powerline-shell.py $MODE --shell zsh $? 2>/dev/null) "
}
if [ x$DISPLAY != x ]; then
    # Enable xterm transparency. Check for transset-df first, though.
    [ -n "$XTERM_VERSION" ] && command -v transset-df >&/dev/null && transset-df -a 0.7 >/dev/null

    if [[ "$ZSH_THEME" == "agnoster" ]]; then
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
fi

[[ -d /usr/local/heroku/bin ]] && export PATH=/usr/local/heroku/bin:$PATH
[[ -d $HOME/.gem/ruby/2.0.0/bin ]] && export PATH=$HOME/.gem/ruby/2.0.0/bin:$PATH
[[ -d $HOME/.gem/ruby/2.1.0/bin ]] && export PATH=$HOME/.gem/ruby/2.1.0/bin:$PATH

export LESS=-RFX

alias ls='ls -hF --color=tty --group-directories-first'
alias ll='ls -lF --group-directories-first'
alias la='ls -AF --group-directories-first'
alias ~-'cd ~'

# TODO: Fork oh-my-zsh to do stuff like this...?
alias yc='xclip -selection clipboard -i '
alias y='xclip -i '
alias pc='xclip -selection clipboard -o'
alias p='xclip -o'

# Easy file 'cutting'
# e.g. $ drop 100 file.txt | take 5
drop() { tail -n +$@ ;}
take() { head -n $@ ;}

cd() { builtin cd $@ && ls ;}

export SHELL=$(which zsh)

export PYTHONSTARTUP=$HOME/.pyrc

# shucks config file
[[ -f $HOME/.shucks ]] && export SHUCKS=$HOME/.shucks

alias -g NUL=' >&/dev/null'
. ~/dotfiles/z/z.sh
