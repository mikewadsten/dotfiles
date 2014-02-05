# Exec tmux automatically, provided we aren't already inside
# the auto-execution of tmux.
# (Similar in nature to the .cshrc exec bash workaround for
# the University of Minnesota.)

# Only exec tmux remote session when SSHing.
if begin
    begin
        set -q SSH_TTY
        or set -q SSH_CLIENT
    end
    and not set -q TMUX
    end

    # Running over SSH, and not already in TMUX.
    if tmux has-session -t remote
        exec tmux attach-session -t remote
    else
        exec tmux new-session -s remote
    end
end

function fish_prompt
    ~/.customizations/powerline-shell.py $status --shell bare ^/dev/null
    echo -e " "
end

set -x SHELL (which fish)

set fish_greeting

set VIRTUAL_ENV_DISABLE_PROMPT 1

set -x PYTHONSTARTUP ~/.pyrc
