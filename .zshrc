#!/usr/bin/env zsh
#   _________  _   _ ____   ____
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |
# _ / /_ ___) |  _  |  _ <| |___
#(_)____|____/|_| |_|_| \_\\____|
#

###############################################################################
# Environment variables

# Expand PATH
for dir in ~/.rvm/bin /usr/local/heroku/bin ~/go/bin ~/node_modules/.bin ~/.npm-packages/bin ~/dev/elm-platform/installers/Elm-Platform/0.16/.cabal-sandbox/bin /usr/local/sbin /usr/local/bin ~/bin; do
    [ -d $dir ] && export PATH=$dir:$PATH
done

export GOPATH=~/go

# Terminal history
export HISTORY=100000
export SAVEHIST=100000
export HISTFILE=$HOME/.history

# Man pager
command -v most >/dev/null && export PAGER=most

export EDITOR=vim
# export BROWSER=elinks
# export LC_TIME=en_DK.utf8 # http://www.explainxkcd.com/wiki/index.php?title=1179

###############################################################################
# Options

# Completion
autoload -U compinit
compinit
unsetopt list_ambiguous
setopt auto_remove_slash # remove last completed '/' on [Space] or [Enter]

# Display the exit code if non-null
setopt print_exit_value

# Ask confirmation for 'rm *'
unsetopt rm_star_silent

# Symlinks handing
setopt chase_links

# Append history to $HISTFILE
setopt append_history

# No dups in history with zsh finder
setopt hist_find_no_dups

# Enable the extended globing features
setopt extendedglob

# Miscellaneous
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
setopt noclobber
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt SH_WORD_SPLIT
setopt nohup

###############################################################################
# Option configurations

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

# colors in completion
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
# tab completion for PID
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

###############################################################################
# Key bindings

# just press the beginning of a previous command then press Up/Down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^U' backward-kill-line

###############################################################################
# Aliases

# Set up auto extension stuff
alias -s html=firefox
alias -s pdf=firefox
alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

# Normal aliases
alias ls='ls --color'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias ll='ls -lh --color'
alias l='ll'
alias lll='ls -lh --color | less'
alias la='ls -A --color'

alias grep='grep --color'

alias -g L='| less'
alias -g G='| grep'
alias -g S='&> /dev/null &'

# Last chance before PNR ;)
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# A few more useful aliases
alias bitch,='sudo' # original idea by rtomayko :D
alias hey='while true; do espeak -z -a 200 -p 70 Hey!; done'
alias se='sudoedit'
alias kernel='dmesg -dH | tail -20'
alias kernel-follow='dmesg -dw'
alias open='xdg-open'
alias vim='vim -p'
alias vv='vim -O'
alias vh='vim -o'
alias v='vim'
alias ssh='ssh -v'
alias tmux='tmux -2' # 256 colors
alias venv='read venv && source ~/.virtualenvs/$venv/bin/activate'

alias todo="ag 'TODO|FIXME|XXX|HACK'"
alias rsynca='rsync -avzPh'
alias netstat='echo ss -ltnp'

alias g='git'
alias gs='git status -s'
alias gl='git log'
alias gb='git branch'
alias gk='git checkout'
alias gp='git pull --rebase'
alias gd='git diff'
alias gdd='git diff --compaction-heuristic --ignore-all-space'
alias glp='git log -p'
alias gc='git commit -v'
alias gca='git commit -av'

alias b='bundle'
alias be='bundle exec'
alias ber='bundle exec rake'
alias bers='bundle exec rspec'
alias berps='bundle exec rake parallel:spec'
alias berpps='bundle exec rake parallel:prepare parallel:spec'
alias rs='bundle exec rails s'
alias rc='bundle exec rails c'
alias rr='bundle exec rails restart'
alias rdbm='rake db:migrate'

alias kcu='knife cookbook upload'
alias kcsi='knife cookbook site install'
alias fs='foreman start'

alias sc='sudo systemctl'
alias pacman='yaourt'
alias y='yaourt'
alias yud='yaourt -Syu --aur --devel'

alias wifi='sudo wifi-menu'
alias ethernet='sudo netctl restart enp0s25 && ip addr'
alias usb_tehering='sudo netctl restart enp0s20u1 && ip addr'
alias arm='sudo -u tor arm'
alias xz-compress-extreme='xz --compress --verbose --keep --check sha256 -9 --extreme'
alias xz-decompress='xz --decompress --verbose --keep'
alias ssh-no-pubkey='\ssh -v -o PubkeyAuthentication=no -o PasswordAuthentication=yes'
alias docker-cleanup='docker rm $(docker ps -q -f status=exited)'
alias redshift-bg='nohup redshift -l geoclue2 -r &> /dev/null &'
alias color-invert='xcalib -invert -alter'
alias weather='curl http://wttr.in/'
alias nectarine='nvlc http://necta-relay.mnus.de:8000/necta192.mp3'

alias loc_report='find app/ -name "*.rb" | xargs wc -l | sort'
alias git_report='git log --name-only --no-merges | grep \.rb$ | sort | uniq -c | sort -nr'

alias minicom-screen='sudo screen /dev/ttyUSB0 115200'

###############################################################################
# Additional configuration

set -o vi
setopt prompt_subst

# Colors
autoload colors zsh/terminfo
[ "$terminfo[colors]" -ge 8 ] && colors

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/git-prompt/zshrc.sh
PROMPT='%B%~%b$(git_super_status) %# '

_set_title() {
    print -Pn "\e]2;%m: %~\a"
}

_set_title

chpwd() {
    _set_title
}

# Ruby
# export RBXOPT=-X19
# ulimit -s 65536 # to avoid "Stack level too deep" errors with Rails

# Load machine specific configuration if any
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# EOF
