function cd --description 'Alias for "cd" function, running ls afterwards.'
    if count $argv >/dev/null
        switch $argv[1]
            case -h --h --he --hel --help
                __fish_print_help cd
                return 0
        end
    end

    switch (count $argv)
        case 0
            builtin cd $HOME
            ls
        case 1
            builtin cd $argv[1]
            ls
        case \*
            echo "Expected 0 or 1 arguments..."
    end
    return 0
end
