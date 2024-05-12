#!/usr/bin/env zsh
#   _________  _   _ ____   ____
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |
# _ / /_ ___) |  _  |  _ <| |___
#(_)____|____/|_| |_|_| \_\\____|
#


###############################################################################
# Environment variables

# Keyboard layout and variant
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=altgr-intl

if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec systemd-cat -t sway sway
fi

# Expand PATH
while read dir; do
    [ -d $dir ] && export PATH=$dir:$PATH || echo "Cannot append $dir to \$PATH"
done <<EOH
$HOME/bin
/usr/local/bin
/usr/local/sbin
EOH

#eval "$(direnv hook bash)"

# Terminal history
export HISTORY=100000
export SAVEHIST=100000
export HISTFILE=$HOME/.history

# Man pager
command -v most >/dev/null && export PAGER=most

export EDITOR=vim
# export BROWSER=elinks
export LC_TIME=en_DK.utf8 # http://www.explainxkcd.com/wiki/index.php?title=1179

###############################################################################
# Options

# Completion
autoload -Uz compinit
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
setopt autocd
setopt autopushd pushdminus pushdsilent pushdtohome
setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
setopt noclobber
setopt nohup
setopt notify
setopt prompt_subst
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SH_WORD_SPLIT

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

bindkey -v # vim bindings

# just press the beginning of a previous command then press Up/Down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^U' backward-kill-line

###############################################################################
# Aliases

# Set up auto extension stuff
alias -s html=firefox
alias -s pdf=firefox
alias -s png=swayimg
alias -s jpg=swayimg
alias -s gif=swayimg
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

# Normal aliases
alias ls='ls --color'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias ll='ls -lh --color'
alias l='ll'
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
alias hey='while true; do espeak -z -a 200 -p 70 --stdout Hey | paplay; sleep 1; done'
alias se='sudoedit'
alias kernel='dmesg -dH | tail -20'
alias kernel-follow='sudo dmesg -dwT'
alias open='xdg-open'
alias vim='vim -p'
alias vv='vim -O'
alias vh='vim -o'
alias v='vim'
alias ssh='ssh -v'
alias ssh-no-pubkey='\ssh -v -o PubkeyAuthentication=no -o PasswordAuthentication=yes'
alias s='kitty +kitten ssh -v'
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
#alias p='sudo pacman'
alias y='yay'
alias yay-cleanup='yay -Yc && yay -Sc --noconfirm && yay -Ps'

alias trash-empty='rm -rfv ~/.local/share/Trash/*'
alias ethernet='enp0s31f6-ethernet-dhcp'
alias usb_tehering='sudo netctl restart enp0s20u1 && ip addr'
alias arm='sudo -u tor arm'
alias xz-compress-extreme='xz --compress --verbose --keep --check sha256 -9 --extreme'
alias xz-decompress='xz --decompress --verbose --keep'
alias docker-cleanup='docker system prune -a -f --volumes'
alias weather='curl http://wttr.in/'
alias nectarine='mpv http://nectarine.from-de.com/necta192'
alias zik='mpv --shuffle --audio-display=no ~/Music'
alias ratm='mpv --shuffle "$HOME/Music/Rage Against the Machine"'
alias bc_sum='paste -s -d+ | bc'
alias firefox-profile='firefox --ProfileManager --new-instance'
alias minicom-screen='sudo screen /dev/ttyUSB0 115200'
alias packer='packer-io'
alias gogo='source gogo'
alias geth='geth --syncmode light'
alias tv='mpv --playlist-tree https://raw.githubusercontent.com/iptv-org/iptv/master/index.m3u'
alias speedtest='speedtest-cli --json | jq'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias kitty-icat='kitty +kitten icat'
alias freetube='freetube --enable-features=UseOzonePlatform --ozone-platform=wayland'

###############################################################################
# Additional configuration

# Colors
autoload colors zsh/terminfo
[ "$terminfo[colors]" -ge 8 ] && colors

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/git-prompt/zshrc.sh
PROMPT='%B%~%b$(git_super_status) %# '

# SSH agent
if ! pgrep ssh-agent > /dev/null; then
    rm -f ~/.ssh-agent-string
    ssh-agent > ~/.ssh-agent-string
fi

if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval $(<~/.ssh-agent-string) >/dev/null
fi

# Golang
export GOPATH=~/go

# Ruby
# https://wiki.archlinux.org/title/ruby#RubyGems
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# Load machine specific configuration if any
[ ! -f ~/.zshrc.local ] || source ~/.zshrc.local

# EOF
