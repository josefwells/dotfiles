# Hello emacs, this is -*- sh -*-

# Install: "apt-get update && apt-get install parallel dnsutils git bash-completion"

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/games

###########################WORK STUFF#########################

if [ -f ~/.bashrc.work ]
then
    . ~/.bashrc.work
fi

if [ -f ~/.bashrc.secure ]
then
    . ~/.bashrc.secure
fi

#########################END WORK STUFF#################################

#term vs screen
if [ "$TMUX" ]; then
    settitle() {
	printf "\033k$1\033\\"
    }
    export TERM=xterm-256color
    ssh () {
	_arg=`echo $*|sed -e 's/[\ Y-]*//'`;
	settitle "$_arg"
	command ssh "$@"
	_exitcode=$?
	tmux setw automatic-rename
	return $_exitcode
    }
    #export PROMPT_COMMAND='tmux rename-window -t ${TMUX_PANE} ${HOSTNAME}:`basename ${PWD}`;'
else
    export TERM=xterm-256color
    export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
fi

# If not running interactively, don't do anything
#[ -z "$PS1" ] && exit

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTSIZE=4095

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='[${debian_chroot:+($debian_chroot)}\W$(__git_ps1 " (%s)")]\$ '
fi
unset color_prompt force_color_prompt

#git grep, then blame on those files... if a file is passed to ggb, files are not shows in git blame.
ggb() { if [ ! -n "$2" ]; then
      	   showfile="-f";
	else
	   showfile="";
	fi;
	git grep -n "$@" | while IFS=: read i j k; do
	    git --no-pager blame $showfile -L $j,$j $i;
	done;
      }

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias cgrep='grep --color=always'
fi

# some more ls aliases
alias l='ls -ltrah'
alias duh='du -hs *|sort -h'
alias dirs='dirs -v'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

z   () { bell; notify-send -t 0 "done"; }
hist() { grep -a $1 ~/.bash_history.archive; }
lhist() { less ~/.bash_history.archive; }

cb  () {
    bell; clear;
    if [ "" == "$1" ]; then banner FOO;
    else banner $@;
    fi
}

cdg () {
   cd `git root`;
}

fp  () {
    if [ -e $1 ]; then
	readlink -f $1;
    else
	echo "$1 not found";
    fi
}
#Docker
docker-rmall () { docker rm `docker ps -a -q`; }

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[ -r ~/.bashrc_history ] && source ~/.bashrc_history

set +o ignoreeof

gr() { grep -iR $1 *; }
alias tm='tmux new-session -A -s main'
if [ -f ~/dotfiles/tmux_bash_completion ]; then
    source ~/dotfiles/tmux_bash_completion
fi
alias rem='rm -if *~ \#*\#'
alias ex='~/bin/emacs-remote'
alias x='~/bin/emacs-remote'
alias h='history'
alias cdp='cd `pwd -P`'
alias bell='echo -e "\a"'
alias p='parallel'
alias tma='tmux a -t'

umask 2

export LESS='-R'
if [ "$EDITOR" == "emacs -nw" ]; then
   export EDITOR="emacs -nw"
   alias vi='$EDITOR'
   alias ec='$EDITOR'
else
   export EDITOR='emacsclient -nw'
   alias vi='$EDITOR --alternate-editor=""'
   alias ec='$EDITOR --alternate-editor=""'
fi
export ALTERNATE_EDITOR='emacsclient -nw'
export GNU_PORT=22490
if [ "$SSH_CLIENT" ]; then
    export GNU_HOST=`echo $SSH_CLIENT | cut -d ' ' -f 1`
fi

#I go first cause I'm cool
export PATH=${HOME}/bin:${PATH}

# Telegram notify
if [ -f ~/.bashrc.telegram ]; then
    source ~/.bashrc.telegram
fi

eval "$(parallel --shell-completion auto)"
