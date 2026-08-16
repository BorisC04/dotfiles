#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C'

GREEN="\[$(tput setaf 2)\]"
BOLD="\[$(tput bold)\]"
RESET="\[$(tput sgr0)\]"

PS1="\W ${GREEN}${BOLD}> ${RESET}"

alias sl='sl -ew5'

eval "$(zoxide init --cmd cd bash)"
