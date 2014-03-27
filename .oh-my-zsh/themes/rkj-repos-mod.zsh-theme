# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: http://bbs.archlinux.org/viewtopic.php?pid=521888#p521888

function hg_prompt_info {
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]+%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]✱%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]✗%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]➦%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[black]✂%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]✈%}"

function mygit() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX%{$fg[magenta]%}${ref#refs/heads/}$( git_prompt_status )%{$reset_color%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
PROMPT=$'
%b%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%n%{$fg[magenta]%}@%b%{$fg[cyan]%}%m %B%{$fg[blue]%}$(mygit)$(hg_prompt_info)
%b%{$fg[yellow]%}[%~]%{$reset_color%}'"${return_status}> "

PS2=$'%B%{$fg_bold[blue]%}%_ >%{\e[0m%}%b '

setopt promptsubst
RPROMPT='%B$(battery_pct_prompt)'%b$'%{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%Y-%m-%d %I:%M:%S"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}'
