Installation
============

This repository contains some git submodules (Vim plugins & my ~/bin), thus you
have to pass the `--recursive` option to `git clone`.

    git clone -b <branch> --recursive git://github.com/infertux/dotfiles.git


Submodules
==========

Adding Submodules
-----------------

Vim plugins that are versioned with Git can be installed as submodules.
For example, to install the [Tagbar bundle][Tagbar], follow these steps:

    cd dotfiles
    git submodule add https://github.com/vim-scripts/Tagbar.git .vim/bundle/Tagbar

This will update the `.gitmodules` file by appending something like:

    [submodule ".vim/bundle/Tagbar"]
        path = .vim/bundle/Tagbar
        url = https://github.com/vim-scripts/Tagbar.git

As well as checkout out the git repo into the
`.vim/bundle/Tagbar` directory. You can then commit these changes
as follows:

    git commit

Most of Vim plugins can be found at https://github.com/vim-scripts.

Updating Submodules
-------------------

Here is an example with Tagbar bundle:

    cd dotfiles
    git submodule update
    cd .vim/bundle/Tagbar
    git checkout master
    git pull
    cd ..
    git add .vim/bundle/Tagbar
    git commit

Removing Submodules
-------------------

Git is a little tricky for that.
First, delete the relevant line from the .gitmodules file.
Then, delete the relevant section from .git/config.
Finally:

    git rm --cached .vim/bundle/Tagbar  # no trailing slash
    git commit
    rm -rf .vim/bundle/Tagbar


[Tagbar]: https://github.com/vim-scripts/Tagbar

