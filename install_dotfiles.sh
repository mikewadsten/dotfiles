# Check that the directory isn't already a Git repository.
if [[ -d ~/.git ]]; then
    echo "It looks like you already have a Git repo in your home directory. Fix that in order to continue."
    exit
fi

# Check that we can back up to dotfiles.old
if [[ -d ~/dotfiles.old ]]; then
    echo "You already have a dotfiles.old directory, so I can't back up there. You'll have to move that."
    exit
fi

# Check that Git and Curl are installed.
hash git 2> /dev/null || {
    echo "Oh dear. I require Git, but it's not installed."
    exit
}

hash curl 2> /dev/null || {
    echo "Oh dear. I require curl, but it's not installed."
    exit
}

# Let the fun begin.
echo
echo "Initializing repository..."
git init

echo
echo "Adding remote origin..."
git remote add origin https://github.com/mikewadsten/dotfiles

echo
echo  "Backing up old dotfiles..."
mkdir dotfiles.old
git ls-tree --name-only origin/master | xargs mv -t dotfiles.old/ > /dev/null 2>&1

echo
echo "Checking out remote branch..."
git checkout -b master remotes/origin/master

echo
echo "Setting up submodules..."
# Set up .vim (vim-files submodule)
git submodule init
git submodule update

# Set up vundle
builtin cd ~/.vim
git submodule init
git submodule update

echo
echo "Previous dotfiles can be found in dotfiles.old directory."

echo
echo "Installing spf13..."
curl http://j.mo/spf13-vim3 -L -o - | sh
