# Install

    PKG="sudo apt-get install" # or "sudo yum install", "sudo pacman -S", etc.
    $PKG git
    git clone https://github.com/infertux/dotfiles.git
    mv -v dotfiles/* dotfiles/.* ~
    rmdir dotfiles
    git submodule update --init --recursive
    git remote set-url origin git@github.com:infertux/dotfiles.git # to push (optional)

## Shell

    $PKG zsh tmux vim
    chsh -s /bin/zsh
    SHELL=/bin/zsh tmux

## SSH

    install -m 0755 -d ~/.ssh/
    install -v -m 0400 /mnt/somewhere/infertux/.ssh/id_* ~/.ssh/

## Tor

If the "Internet" isn't really the Internet, a local copy of the Tor Browser can be found in the Downloads/ directory.

    cd Downloads/
    gpg --keyserver pool.sks-keyservers.net --recv-keys 0x4E2C6E8793298290
    gpg --verify tor-browser-linux64-*_en-US.tar.xz.asc
    xz --decompress --verbose --keep tor-browser-linux64-*_en-US.tar.xz
    tar xvf tor-browser-linux64-*_en-US.tar
    ./tor-browser_en-US/Browser/start-tor-browser

## Music

    $PKG vlc
    nectarine


# Update

## Adding submodules

    git submodule add -f --name vim-plugin-solarized https://github.com/altercation/vim-colors-solarized.git .vim/pack/plugins/start/solarized
    git commit

## Updating submodules

    git submodule update --remote

## Removing submodules

    git submodule deinit .vim/pack/plugins/start/solarized
    git rm .vim/pack/plugins/start/solarized
    git commit
