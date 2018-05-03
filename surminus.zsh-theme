local ret_status="%(?:%{$fg_bold[green]%}$(random_emoji animals)% :%{$fg_bold[red]%}$emoji[cross_mark])"
PROMPT='${ret_status} %{$fg[cyan]%}%~%{$reset_color%}$(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
