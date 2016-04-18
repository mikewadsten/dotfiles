# Start X at login on Arch boxes
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    if hash startx 2>& /dev/null; then
        startx && logout
        exit
    fi
fi

[[ -z "$EDITOR" ]] && export EDITOR=vim

COMPLETION_WAITING_DOTS="true"
source "$HOME/.antigen.zsh"

ZSH="$HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh.git"

antigen bundles <<EOBUNDLES
    mikewadsten/oh-my-zsh custom
    zsh-users/zsh-syntax-highlighting
    git
    pip
    command-not-found
    rupa/z
    python
    virtualenvwrapper
EOBUNDLES

export WORKON_HOME=$HOME/.envs

# Fix using SSH in urxvt, and tmux over SSH
if [[ $TERM == 'rxvt-unicode' ]] || [[ -n "$SSH_TTY" ]]; then
    export TERM='screen-256color'
fi

# Bail out outside of X, or something like that.
[[ "$TERM" == "linux" ]] && return;

autoload -U colors && colors
PS1="%{$fg[red]%}%n@%m %~ %{$fg_bold[red]%}λ%{$reset_color%} "

alias virtualenv='virtualenv2'
pip() { pip2 $@ ;}

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nonomatch
bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() { vcs_info ;}

GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

zstyle ':vcs_info:git+set-message:*' hooks git-fancy
function +vi-git-fancy() {
    local ahead behind
    local -a gitab stoplight

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitab+=( "+${ahead}" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitab+=( "-${behind}" )

    # Determine if there are any untracked files
    if [[ -n $(git ls-files --other --exclude-standard 2>/dev/null) ]]; then
        stoplight+=( "$GIT_PROMPT_UNTRACKED" )
    fi
    # Determine if there are any modified files
    if ! git diff --quiet 2>/dev/null; then
        stoplight+=( "$GIT_PROMPT_MODIFIED" )
    fi
    # Determine if there are any staged files
    if ! git diff --cached --quiet 2>/dev/null; then
        stoplight+=( "$GIT_PROMPT_STAGED" )
    fi

    # Build up the final fancy status bit
    local -a pieces
    if [[ ${#gitab[@]} != "0" ]]; then
        pieces+=${(j:/:)gitab}
    fi
    if [[ ${#stoplight[@]} != "0" ]]; then
        pieces+=${(j: :)stoplight}
    fi

    hook_com[misc]+=${(j: :)pieces}
}

setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%{$fg_bold[red]%}●%{$reset_color%}"
# Output formats
zstyle ':vcs_info:git:*' formats "%m %{$fg[cyan]%}%b%{$reset_color%}"
zstyle ':vcs_info:git:*' actionformats "%m %{$fg[yellow]%}%a %{$fg[cyan]%}%b%{$reset_color%}"
# Stick Git status info in the right-hand prompt
export RPS1='${vcs_info_msg_0_}'

export LESS=-RFX

alias ls='ls -hF --color=auto --group-directories-first'
alias ll='ls -lhF --group-directories-first'
alias la='ls -AF --group-directories-first'
alias ~='cd ~'

cd() { builtin cd $@ && ls ;}

export PYTHONSTARTUP=$HOME/.pyrc

bindkey "^r" history-incremental-search-backward
export PAGER=less

antigen apply

antigen bundle mikewadsten/oh-my-zsh lib/key-bindings.zsh

export PATH=$PATH:$HOME/bin

setopt autonamedirs

[[ -f $HOME/.zshrc.digi ]] && source $HOME/.zshrc.digi

command -v nvim 2>&1 >/dev/null && alias vim='DISPLAY=:0 nvim'
command -v make 2>&1 >/dev/null && alias make='make -s --no-print-directory'

take() { head -n $@ ;}
drop() { head -n -$@ ;}

othergit() {
    local dir="$1"
    if [[ "$1" == "" ]]; then
        echo "$0: Need to provide at least a directory path..."
        return 1
    fi
    if [[ ! -d "$1/.git" ]]; then
        echo "$0: '$1/.git' does not exist"
        return 1
    fi
    shift

    git --git-dir="$dir/.git" --work-tree="$dir" $@
}
