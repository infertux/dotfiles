#!/usr/bin/env zsh
#   _________  _   _ ____   ____
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |
# _ / /_ ___) |  _  |  _ <| |___
#(_)____|____/|_| |_|_| \_\\____|
#

###############################################################################
# Environment variables

# Append ~/bin to PATH
[ -d ~/bin ] && export PATH=~/bin:$PATH

# Terminal history
export HISTORY=100000
export SAVEHIST=100000
export HISTFILE=$HOME/.history

# Man pager
command -v most >/dev/null && export PAGER=most

export EDITOR=vim
export BROWSER=elinks

# Export 'ls' colors
command -v dircolors >/dev/null && eval $(dircolors -b)

###############################################################################
# Options

# Prompt


# Completion
autoload -U compinit
compinit
unsetopt list_ambiguous
setopt auto_remove_slash # remove last completed '/' on [Space] or [Enter]

# Display the exit code if non-null
setopt print_exit_value

# Ask confirmation for 'rm *'
unsetopt rm_star_silent

# When using wildcards in the list of arguments,
# removes the jokers that do not match anything instead of giving an error
setopt nullglob

# Symlinks handing
setopt chase_links

# Append history to $HISTFILE
setopt append_history

# No dups in history with zsh finder
setopt hist_find_no_dups

# Correct mistyped commands
setopt correctall

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
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

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

zle-keymap-select () {
    if [ $TERM = "rxvt-unicode" -o $TERM = "rxvt-256color" \
        -o $TERM = "screen" ]; then
        if [ $KEYMAP = vicmd ]; then
            [ $TERM = "screen" ] && echo -ne "\033P\033]12;Green\007\033\\" \
                                 || echo -ne "\033]12;Green\007"
        else
            [ $TERM = "screen" ] && echo -ne "\033P\033]12;Red\007\033\\" \
                                 || echo -ne "\033]12;Red\007"
        fi
    fi
}
zle -N zle-keymap-select
zle-line-init () {
    # FIXME: SEGFAULT when a b"c<ENTER><CTRL-C>
    zle -K viins
    if [ $TERM = "rxvt-unicode" -o $TERM = "rxvt-256color" \
        -o $TERM = "screen" ]; then
        [ $TERM = "screen" ] && echo -ne "\033P\033]12;Red\007\033\\" \
                             || echo -ne "\033]12;Red\007"
    fi
}
zle -N zle-line-init

# just press the beginning of a previous command then press Up/Down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^U' backward-kill-line

###############################################################################
# Aliases

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
alias -s pdf=zathura
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
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
alias kernel='dmesg | tail'
alias v='vim'
alias vim='vim -p'
alias ssh='ssh -v'

alias dev='cd /data/Dev/'
alias todo="ack 'TODO|FIXME|XXX|HACK'"

alias g='git'
alias gs='git st'
alias gl='git log'
alias gb='git br'
alias go='git co'
alias gp='git pull --rebase'
alias gd='git diff'

alias be='bundle exec'
alias ber='bundle exec rake'
alias bers='bundle exec rspec'


###############################################################################
# Additional configuration

setopt prompt_subst

# Colors

autoload colors zsh/terminfo
[ "$terminfo[colors]" -ge 8 ] && colors


_git_prompt_info() {
    _git_branch() {
        git branch | awk '{if ($1 = "*"); print $2}' | tr -d "\n"
    }

    _git_dirty() {
        git status --porcelain | wc -l
    }

    echo -n "%{$fg[yellow]%} ($(_git_branch)|"
    count=$(_git_dirty)
    [ $count -ne 0 ] && echo -n "%{$fg[red]%}$count%{$reset_color%}" || echo -n "%{$fg[green]%}✔%{$reset_color%}"
    echo -n "%{$fg[yellow]%})%{$reset_color%}"
}

_rcs_prompt_info() {
    git status &>/dev/null && _git_prompt_info
}

precmd() {
    local return_code="%(?..%{$fg[red]%}%?!%{$reset_color%})"

    PROMPT="%{$fg[red]%}${PWD/#$HOME/~}$(_rcs_prompt_info) %{$fg[white]%}%(!.#.%%) "
    RPROMPT="$return_code%{$fg[white]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[blue]%}%l%{$fg[white]%}"

    echo -en "\033]0;${HOSTNAME}\007"
}

_setup_ssh() {
    case "$1" in
        ssh|scp|git|sshfs)
            # SSH agent
            command -v keychain >/dev/null && eval `keychain --eval --agents ssh -q id_rsa`
            # Set the right title on urxvt
            shift $(($# - 1))
            echo -en "\033]0;$1\007"
            ;;
    esac
}

preexec() {
    _setup_ssh $*
}

# Load machine specific configuration if any
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
[[ -s "/home/infertux/.rvm/scripts/rvm" ]] && source "/home/infertux/.rvm/scripts/rvm"

###############################################################################
# Display system info

uname -snr
w -h

# EOF

