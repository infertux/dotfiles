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
[ -d ~/bin ] && export PATH=$PATH:~/bin

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
autoload -U promptinit
promptinit
prompt adam2

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

# Vi mode
set -o vi
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

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

###############################################################################
# Aliases

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
alias -s pdf=xpdf
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

# Normal aliases
alias ls='ls -G'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias ll='ls -Glh'
alias l='ll'
alias lll='ls -Glh | less'
alias la='ls -GA'

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
alias vpn='cd /etc/openvpn && sudo openvpn '
alias se='sudoedit'
alias ss='sudo service'

alias dev='cd /data/Dev/'
alias todo="ack 'TODO|FIXME|XXX|HACK'"

alias gs='git st'
alias unsvn='find . -name .svn -print0 | xargs -0 rm -rf'
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add'

###############################################################################
# Additional configuration

setup_ssh() {
    if [[ "$1" = "ssh" || "$1" = "scp" ]]; then
        # SSH agent
        eval `keychain --eval --agents ssh -q id_rsa`
        # Set the right title on urxvt
        shift $(($# - 1))
        echo -en "\033]0;$1\007"
    fi
}
precmd() { echo -en "\033]0;${HOSTNAME}\007" }
preexec() { setup_ssh $* }

# Load machine specific configuration if any
[ -f ./.zshrc.local ] && . ./.zshrc.local

###############################################################################
# Display system info

uname -snr
w

# EOF

