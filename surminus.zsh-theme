# Prompt a random emoji animal. Worth noting that fg[blue] comes up as grey in
# my colour scheme

# Show a random animal emoji for good status, and fire for bad status
local ret_status="%(?:$(random_emoji animals):$emoji[fire])"

# <emoji> /path/to/dir(git_info)
PROMPT='${ret_status} %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="!"
