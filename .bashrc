# LastAvengers' .bashrc
# ~/.bashrc
# date: 2015-7-21

# less colorful output
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# alias
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# wechall scoreboard
export WECHALLUSER="LastAvengers"
export WECHALLTOKEN="ED8E2-83FF7-4AD9B-4CF7B-FF06B-80DCF"
