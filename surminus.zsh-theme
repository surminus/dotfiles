# Prompt a random emoji animal. Worth noting that fg[blue] comes up as grey in
# my colour scheme

# Show a random animal emoji for good status, and fire for bad status
local ret_status="%(?:$(random_emoji animals):$emoji[fire])"

function path() {
  echo "%{$fg_bold[blue]%}%~%{$reset_color%}"
}

function prefix() {
  echo "%{$fg_bold[blue]%}(%{$fg[red]%}"
}

function suffix {
  echo "%{$fg[blue]%})%{$reset_color%}"
}

# <emoji> /path/to/dir(git_info)
PROMPT='${ret_status} $(path)$(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX="$(prefix)"
ZSH_THEME_GIT_PROMPT_SUFFIX="$(suffix)"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="!"
