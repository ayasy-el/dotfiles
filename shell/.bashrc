#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

eval "$(zoxide init bash)"
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.python_env/bin:$PATH"

. "$HOME/.local/bin/env"


# Added by Antigravity CLI installer
export PATH="/home/ayasy/.local/bin:$PATH"
