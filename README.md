Installation
============

This repository contains some git submodules (Vim plugins & my ~/bin), thus you
have to pass the `--recursive` option to `git clone`.

    git clone --recursive git://github.com/infertux/dotfiles.git


VIM
===

Adding plugin bundles
---------------------

Plugins that are versioned with Git can be installed as submodules. For example,
to install the [Tagbar bundle][Tagbar], follow these steps:

    cd dotfiles
    git submodule add https://github.com/vim-scripts/Tagbar.git .vim/bundle/Tagbar

This will update the `.gitmodules` file by appending something like:

    [submodule ".vim/bundle/Tagbar"]
        path = .vim/bundle/Tagbar
        url = https://github.com/vim-scripts/Tagbar.git

As well as checkout out the git repo into the
`.vim/bundle/Tagbar` directory. You can then commit these changes
as follows:

    git add .
    git commit -m "Added the Tagbar bundle"

Updating plugin bundles
---------------------

TODO

Removing plugin bundles
---------------------

TODO


[Tagbar]: https://github.com/vim-scripts/Tagbar

