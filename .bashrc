#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.common_settings.sh

SKYBLUE="\[$(tput setaf 74)\]"
DEEPSKY="\[$(tput setaf 39)\]"
RESET="\[$(tput sgr0)\]"

PS1="${DEEPSKY}[${RESET}${SKYBLUE}\u@\h${RESET} \W${DEEPSKY}]${RESET}\$ "
