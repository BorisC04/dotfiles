#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C'
PS1='[\u@\h \W]\$ '

alias sl='sl -ew5'

eval "$(zoxide init --cmd cd bash)"
