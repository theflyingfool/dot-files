###############################################################################
#
# ~/.zshrc
#
# Dot file git:
# 	https://
#
# Maintainer:
#	TheFlyingFool - tff@theflyingfool.com
#	http://theflyingfool.com
#
#
###############################################################################

# Skip erything for non-interactive shell
[[ -z "$PS1" ]] && return

##History
HISTFILE=~/.zsh_history
HISTSIZE=25000
SAVEHIST=12500
setopt INC_APPEND_HISTORY
setopt incappendhistory
setopt sharehistory
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_ALL_DUPS
# make history searchable with ctrl-r
bindkey "^r" history-incremental-search-backward

##Variables
export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export BROWSWER="vivaldi"
# fixes issue with atom 
export ELECTRON_TRASH="kioclient5 atom"


##Alias
source ~/.alias

setopt appendhistory autocd beep nomatch correct noclobber
unsetopt extendedglob notify
bindkey -v

zstyle :compinstall filename '/home/nick/.zshrc'

autoload -U compinit
compinit


zstyle ':completion:*' rehash true
##Colored man pages

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


##Command not found
##Requires extra/pkgfile -- Arch Linux
if [ -f "/usr/share/doc/pkgfile/command-not-found.zsh" ]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi


#eval 'keychain --eval id_ed25519'
if [[ -f /usr/bin/keychain ]] then
	keychain --agents gpg,ssh id_ed25519 31936033 github_rsa
		[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n` 
		[ -f $HOME/.keychian/$HOSTNAME-sh ] 
			source  $HOME/.keychain/$HOSTNAME-sh ]
		[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] 
			source $HOME/.keychain/$HOSTNAME-sh-gpg
fi

##Prompt

#Load Colors for Prompt
autoload -U colors && colors
#Enables a quick prompt switch, can be used with 
# %prompt -l    #Lists Prompts
# %prompt name  #Selects Prompt

if [[ -n $SSH_CLIENT ]]; then
	PROMPT="[%{$fg[yellow]%}%n%{$reset_color%}@%B%{$fg[red]%}%M%{$reset_color%}]%{$reset_color%}-%{$reset_color%}[%{$fg[green]%}%~%{$reset_color%}]
%#"
else
	PROMPT="[%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[cyan]%}%M%{$reset_color%}]%{$reset_color%}-%{$reset_color%}[%{$fg[green]%}%~%{$reset_color%}]
%#"
fi

###Alias
#alias aurup="cd ~/AUR && echo $PWD && cower -ubddf --color" #AUR Update
#alias aurSs="cd ~/AUR && cower -s --color"                  #Search AUR
#alias aurS="cd ~/AUR && cower -dd --color"                  #Download PKGBUILD and depends
#ZFS Related						    #zfs, and zpool both set to NOPASSWD via sudoers file
#alias zfs="sudo zfs"					    
#alias zpool="sudo zpool"
#alias scrub="sudo zpool scrub"			            #preforms scrub



# Adapted from code found at <https://gist.github.com/1712320>.
 
setopt prompt_subst
# Modify the colors and symbols in these variables as desired.
#GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
 
# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
 
# Show different symbols as appropriate for various Git repository states
parse_git_state() {
 
  # Compose this value via multiple conditional appends.
  local GIT_STATE=""
 
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi
 
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
 
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi
 
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi
 
  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi
 
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi
 
  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
 
}
 
# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}
 
## alt-s inserts "sudo" at start of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


# Set the right-hand prompt
RPS1='$(git_prompt_string)'
