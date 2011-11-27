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
for dir in /usr/local/sbin /usr/local/bin ~/bin; do
    [ -d $dir ] && export PATH=$dir:$PATH
done

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
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn

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

###############################################################################
# Aliases

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
alias -s pdf=zathura
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s txt=$EDITOR

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
alias vim='vim -p'
alias vv='vim -O'
alias vh='vim -o'
alias v='vim'

alias todo="ack 'TODO|FIXME|XXX|HACK'"
alias ack='ack -a'

alias g='git'
alias gs='git st'
alias gl='git log'
alias glp='git log -p'
alias gb='git br'
alias go='git co'
alias gc='git ci -av'
alias gca='git ci -av --amend'
alias gp='git pull --rebase'
alias gg='git push' # "Git Give"
alias gd='git diff'

alias be='bundle exec'
alias ber='bundle exec rake'
alias bers='bundle exec rspec'

alias kcu='knife cookbook upload'


###############################################################################
# Additional configuration

precmd() {
    echo -en "\033]0;${HOSTNAME}\007"

    _vcs_info_wrapper() {
      vcs_info
      if [ "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
      fi
    }

   _ruby_version() {
       echo "{$(rvm current)}"
   }

    PROMPT='%~ '
    RPROMPT=$'$(_ruby_version)-$(_vcs_info_wrapper)'
}
preexec() {
    _setup_ssh() {
        if [[ "$1" = "ssh" || "$1" = "scp" ]]; then
            # SSH agent
            command -v keychain >/dev/null && eval `keychain --eval --agents ssh -q id_rsa`
            # Set the right title on urxvt
            shift $(($# - 1))
            echo -en "\033]0;$1\007"
        fi
    }

    _setup_ssh $*
}

# Load machine specific configuration if any
[ -f ./.zshrc.local ] && . ./.zshrc.local
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

###############################################################################
# Display system info

uname -snr
w

# EOF

