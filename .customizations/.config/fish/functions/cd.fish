function cd
    if not set -q $argv[1]
        builtin cd $HOME
    else
        builtin cd $argv
    end
    ls
end
