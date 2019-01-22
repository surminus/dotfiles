# Prompt a random emoji animal. Worth noting that fg[blue] comes up as grey in
# my colour scheme

# Show a random animal emoji for good status, and fire for bad status
local ret_status="%(?:$(random_emoji animals):$emoji[fire])"

function tmux_path() {
  if [[ $TMUX == "" ]]; then
    echo "%{$fg_bold[blue]%}%~%{$reset_color%}"
  else
    echo ""
  fi
}

function tmux_git_prefix() {
  if [[ $TMUX == "" ]]; then
    echo "%{$fg_bold[blue]%}(%{$fg[red]%}"
  else
    echo "%{$fg_bold[blue]%}git:%{$fg_bold[red]%}"
  fi

}

function tmux_git_suffix {
  if [[ $TMUX == "" ]]; then
    echo "%{$fg[blue]%})%{$reset_color%}"
  else
    echo "%{$reset_color%}"
  fi
}

# <emoji> /path/to/dir(git_info)
PROMPT='${ret_status}$(tmux_path)$(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX="$(tmux_git_prefix)"
ZSH_THEME_GIT_PROMPT_SUFFIX="$(tmux_git_suffix)"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="!"
