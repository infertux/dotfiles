Installation
============

    git clone -b <branch> --recursive git@github.com:infertux/dotfiles.git


Submodules
==========

Adding Submodules
-----------------

Vim plugins that are versioned with Git can be installed as submodules.
For example, to install the [Tagbar bundle][Tagbar], follow these steps:

    git submodule add https://github.com/vim-scripts/Tagbar.git .vim/bundle/Tagbar
    git commit

Most Vim plugins can be found at https://github.com/vim-scripts.

Updating Submodules
-------------------

    git submodule update --remote

Removing Submodules
-------------------

    git submodule deinit .vim/bundle/Tagbar
    git rm .vim/bundle/Tagbar
    git commit


[Tagbar]: https://github.com/vim-scripts/Tagbar

