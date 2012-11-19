Dotfiles
========

These are my dotfiles.
There are many like them but these ones are mine.

Installation
------------
In order to use these dotfiles, you probably should install them. Below are two
methods of doing so.

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
