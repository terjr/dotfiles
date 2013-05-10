source ~/.git-prompt.sh

PS1="\[\033[0;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;34m\]\h'; fi)\[\033[0;36m\] \w\033[0;35m\]\$(__git_ps1)\033[0;36m\]\$\[\033[00m\] "

alias sx="startx"
alias xm="xinit ~/.xinitrc-xmonad"
alias v="vim"

# Colored man pages with less
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
