# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mike/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh

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

export PATH=/usr/local/heroku/bin:$PATH
export PATH=$HOME/.gem/ruby/2.0.0/bin:$PATH

export LESS=-RFX

cd() { builtin cd $@ && ls ;}

export SHELL=$(which zsh)
