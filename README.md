Installation

    git clone git://github.com/infertux/dotfiles.git

Where possible, Vim plugins are installed as git submodules. Check these out by
running the commands:

    cd dotfiles
    git submodule update --init

VIM
===

Adding Plugin Bundles
---------------------

Plugins that are published on github can be installed as submodules. For
example, to install the [Tagbar bundle], follow these steps:

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

