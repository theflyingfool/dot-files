################################################################################
#
# ~/.bashrc
#
# https://git.theflyingfool.com/theflyingfool/dot/blob/master/bash/bashrc
#
# Maintainer:
#	TheFlyingFool - tff@theflyingfool.com
#	http://theflyingfool.com
#
# Version:
#	21/02/2015 23:03
#
################################################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Add color support to man pages
man() {
	env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	    LESS_TERMCAP_md=$(printf "\e[1;31m") \
	    LESS_TERMCAP_me=$(printf "\e[0m") \
	    LESS_TERMCAP_se=$(printf "\e[0m") \
	    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	    LESS_TERMCAP_ue=$(printf "\e[0m") \
	    LESS_TERMCAP_us=$(printf "\e[1;32m") \
	    man "$@"
}

#better color support for ls
eval $(dircolors -b)

#alias

source ~/.alias

#less highlighting
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '

## Typing a dir without cd will change directories anyway
shopt -s autocd  

## Allows for tab completion using sudo / man
complete -cf sudo
complete -cf man


shopt -s checkwinsize

shopt -s histappend

[[ "$PS1" ]] && /usr/bin/fortune

PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
#PS1='[\u@\h \W]\$ '
PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
                                                        
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion



