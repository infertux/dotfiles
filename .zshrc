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
export PAGER=most

export EDITOR=vim
export BROWSER=elinks

# Export 'ls' colors
eval $(dircolors -b)

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

typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

bindkey "^[[H" beginning-of-line # Home
bindkey "^[[F" end-of-line       # End
bindkey "^[[3~" delete-char      # Del

# rxvt and derivatives: wterm, ... and TERM=linux consoles
bindkey "^[[1~" beginning-of-line # Home
bindkey "^[[4~" end-of-line       # End

# for terminals
bindkey "^[OH"  beginning-of-line # Home
bindkey "^[OF"  end-of-line       # End

# for vte terminals
bindkey "^[[2~" overwrite-mode          # Insert
bindkey "^[[5~" history-search-backward # PgUp
bindkey "^[[6~" history-search-forward  # PgDn

# Others
bindkey "Left"  beginning-of-line # Home
bindkey '^C'  end-of-line         # End

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

if [[ -z $DISPLAY && $(setxkbmap -print | grep bepo) != '' ]]; then
    bindkey -v

    # remap
    bindkey -a c vi-backward-char
    bindkey -a r vi-forward-char
    bindkey -a t vi-down-line-or-history
    bindkey -a s vi-up-line-or-history
    bindkey -a $ vi-end-of-line
    bindkey -a 0 vi-digit-or-beginning-of-line
    bindkey -a h vi-change
    bindkey -a H vi-change-eol
    bindkey -a dd vi-change-whole-line
    bindkey -a l vi-replace-chars
    bindkey -a L vi-replace
    bindkey -a k vi-substitute
fi

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
alias ls='ls --color=auto'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias ll='ls --color=auto -lh'
alias l='ll'
alias lll='ls --color=auto -lh | less'
alias la='ls --color=auto -A'

alias grep='grep --color'

alias -g L='| less'
alias -g S='&> /dev/null &'

# Last chance before PNR ;)
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# A few more useful aliases
alias bitch,=sudo # original idea by rtomayko :D
alias hey='while true; do espeak -z -a 200 -p 70 Hey!; done'
alias vpn='cd /etc/openvpn && sudo openvpn '

###############################################################################
# Additional configuration

# Load machine specific configuration if any
[ -f ./.zshrc.local ] && . ./.zshrc.local

###############################################################################
# Nice banner

cat << "EOF"
o          `O    Oo    `o    O  o.OOoOoo       O       o OooOOo.
O           o   o  O    o   O    O             o       O O     `O
o           O  O    o   O  O     o             O       o o      O
O           O oOooOoOo  oOo      ooOO          o       o O     .o
o     o     o o      O  o  o     O             o       O oOooOO'
O     O     O O      o  O   O    o             O       O o
`o   O o   O' o      O  o    o   O             `o     Oo O
 `OoO' `OoO'  O.     O  O     O ooOooOoO        `OoooO'O o'


  .oOOOo.  o      O o.OOoOoo o.OOoOoo OooOOo.   o      o.OOoOoo
  o     o  O      o  O        O       O     `O O        O
  O.       o      O  o        o       o      O o        o
   `OOoo.  OoOooOOo  ooOO     ooOO    O     .o o        ooOO
        `O o      O  O        O       oOooOO'  O        O
         o O      o  o        o       o        O        o
  O.    .O o      o  O        O       O        o     .  O
   `oooO'  o      O ooOooOoO ooOooOoO o'       OOoOooO ooOooOoO

                  FACEBOOK IS RUN BY THE CIA

        .-/                                      .-.
      _.-~ /  _____  ______ __  _    _     _   ___ | ~-._
      \:/  -~||  __||_  __//  || |  | |  /| | / __/| .\:/
       /     ||  __|:| |\:/ ' || |__| |_/:| || (:/:|   \
      / /\/| ||____|:|_|:/_/|_||____|____||_|:\___\| |\ \
     / /:::|.:\::::\:\:\:|:||:||::::|:::://:/:/:::/:.|:\ \
    / /:::/ \::\::::\|\:\|:/|:||::::|::://:/\/:::/::/:::\ \
   /  .::\   \-~~~~~~~ ~~~~  ~~ ~~~~~~~~ ~~  ~~~~~-/\/:..  \
  /..:::::\                                         /:::::..\
 /::::::::-                                         -::::::::\
 \:::::-~                   RULES!                     ~-:::::/
  \:-~                                                    ~-:/

EOF

# Display system info
uname -snr
w

# EOF

