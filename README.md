# Install

    PKG=apt-get # apt-get|yum|pacman
    sudo $PKG install git
    git clone https://github.com/infertux/dotfiles.git
    mv -v dotfiles/* dotfiles/.* ~
    rmdir dotfiles
    git submodule update --init --recursive

## Shell

    sudo $PKG install zsh tmux vim
    chsh -s /bin/zsh
    SHELL=/bin/zsh tmux

## SSH

    install -m 0755 -d ~/.ssh/
    install -v -m 0400 /mnt/somewhere/infertux/.ssh/id_* ~/.ssh/

## Browser

    sudo $PKG install torbrowser-launcher

## Music

    sudo $PKG install vlc


# Update

## Adding submodules

Vim plugins that are versioned with Git can be installed as submodules.
For example, to install the [Tagbar bundle](https://github.com/vim-scripts/Tagbar), follow these steps:

    git submodule add https://github.com/vim-scripts/Tagbar.git .vim/bundle/Tagbar
    git commit

Most Vim plugins can be found at https://github.com/vim-scripts.

## Updating submodules

    git submodule update --remote

## Removing submodules

    git submodule deinit .vim/bundle/Tagbar
    git rm .vim/bundle/Tagbar
    git commit
