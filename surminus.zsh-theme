# Prompt a random emoji animal. Worth noting that fg[blue] comes up as grey in
# my colour scheme

# If inside a git repo, outputs the repo and path underneath the repo, example:
# git:repo_name/some/path/in/repo
function git_dir() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    repo=$(basename -s .git `git config --get remote.origin.url`)
    echo "$fg[red]git$fg_bold[blue]:$repo$(pwd |sed "s/^.*$(gitdir)//")"
  else
    pwd | sed "s,$HOME,~,g"
  fi
}

# Show a random animal emoji for good status, and fire for bad status
local ret_status="%(?:$(random_emoji animals):$emoji[fire])"

# <emoji> /path/to/dir(git_info)
PROMPT='${ret_status} %{$fg_bold[blue]%}$(git_dir)%{$reset_color%}$(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="!"
