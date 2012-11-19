Dotfiles
========

These are my dotfiles.
There are many like them but these ones are mine.


Installation
------------
In order to use these dotfiles, you probably should install them. I have taken
to disliking the manual installation method, and so it is automated into the
[automatic installation script][installer] used below.

### Automatic Installation
The dotfiles can be installed just by running the automatic installer located in
this repository.

**Note:** Piping `curl` straight into `sh` can be very dangerous. Please,
please, look over any file that you are doing this for. In this case, the
original file can be viewed [here][installer].

[installer]: https://github.com/mikewadsten/dotfiles/blob/master/install_dotfiles.sh

To install, use one of the commands listed below:

Using `curl`:

```shell
    curl -L https://raw.github.com/mikewadsten/dotfiles/master/install_dotfiles.sh | sh
```

Using `wget`:

```shell
    wget https://raw.github.com/mikewadsten/dotfiles/master/install_dotfiles.sh -O | sh
```

### Manual Installation
1. Clone the repository.
```shell
    git clone https://github.com/mikewadsten/dotfiles
```

2. Copy all of the dotfiles to your home directory. Have fun...

3. Install spf13.
```shell
    curl http://j.mp/spf13-vim3 -L -o - | sh
```

4. ???

5. Profit!
