function cd --description 'Alias for "cd" function, running ls afterwards.'
    if count $argv >/dev/null
        builtin cd $argv[1]
        if [ "$argv[1]" = "-h" -o "$argv[1]" = "--help" ]
            # Return now, because we were just asking for help...
            return
        end
    else
        builtin cd $HOME
    end
    ls
end
