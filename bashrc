#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth



# .bash_history file max size
HISTFILESIZE=100000

export PATH=$PATH:$HOME/.local/bin
export MOZ_USE_XINPUT2=1

export EDITOR='emacsclient -c -a emacs'
export VISUAL='emacsclient -c -a emacs'
export BROWSER='firefox'


bind "set completion-ignore-case on"


#shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s dirspell
shopt -s cdspell
#shopt -s histappend # do not overwrite history
#shopt -s expand_aliases # expand aliases

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# # # ex = EXtractor for all kinds of archives
# # # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjvf $1   ;;
      *.tar.gz)    tar xzvf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar-free x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xvf $1    ;;
      *.tbz2)      tar xjvf $1   ;;
      *.tgz)       tar xzvf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xvf $1    ;;
      *.tar.zst)   tar xvf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# aliases can go here maybe?
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'



# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


alias cd..='cd ..'
alias pdw="pwd"


#alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"


alias ls='ls --color=auto'
alias ll='ls -lF --color=auto'
alias la='ls -A --color=auto'
alias lla='ls -lA --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias his='history | head'
alias record='ffmpeg -f x11grab -video_size 2880x1620 -framerate 25 -i $DISPLAY -f alsa -i default -c:v libx264 -preset ultrafast -c:a aac'
alias serve='python3 -m http.server'

#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w \[\e[0m\]\$ '
