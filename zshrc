# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export SHELL=/bin/zsh

ZSH_THEME="robbyrussell"
test -f ~/.oh-my-zsh/custom/themes/surminus.zsh-theme && ZSH_THEME="surminus"

plugins=(
  asdf
  aws
  docker
  emoji
  fzf
  github
  golang
  node
  opentofu
  pass
  rake
  ruby
  ubuntu
  zsh-autosuggestions
)

autoload -U compinit && compinit

# Home bin
export PATH="$HOME/bin:$PATH:"

# autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=238
export TERM="xterm-256color"

# hub
if [ -e /usr/local/bin/hub ]; then
  eval "$(hub alias -s)"
  if [ -e ~/.zsh/completions/_hub ]; then
    fpath=(~/.zsh/completions $fpath)
    autoload -U compinit && compinit
  fi
fi

# Bundler
export BUNDLE_AUTO_INSTALL=true

if command -v bundle >/dev/null 2>&1; then
  test -d $HOME/.bundle || mkdir -p $HOME/.bundle
  if ! test -f $HOME/.bundle/config || ! grep -q BUNDLE_PATH $HOME/.bundle/config; then
    bundle config set --local path "$HOME/.bundle"
  fi
fi

# awscli v2
export AWS_PAGER="less -XFR"

# GitHub CLI
export GH_PAGER="less -XFR"

# ablyctl
if command -v ablyctl >/dev/null 2>&1; then
  mkdir -p ~/.oh-my-zsh/completions
  ablyctl completion zsh > ~/.oh-my-zsh/completions/_ablyctl
  export ABLYCTL_PAGER="less -XFR"
fi

# load oh-my-zsh
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# toolkit
if test -d ~/surminus/toolkit; then
  export PATH=$HOME/surminus/toolkit:$PATH
fi

# Search (fzf and fd)
#
# If installed using apt, then it may be called fdfind
if command -v fdfind >/dev/null 2>&1; then
  FD_COMMAND="fdfind"
elif command -v fd >/dev/null 2>&1; then
  FD_COMMAND="fd"
fi

# I like fd, but the globbing zsh behaviour
# means it doesn't work so well
[[ -n $FD_COMMAND ]] && alias fd="noglob ${FD_COMMAND}"

if test -d $HOME/.fzf; then
  if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
  fi

  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null
  source "$HOME/.fzf/shell/key-bindings.zsh"

  [[ -n $FD_COMMAND ]] && export FZF_DEFAULT_COMMAND="${FD_COMMAND} --type f --hidden --follow --exclude '.git'"
fi

# Enable pass extensions
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# ripgrep config file
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# Like MacOS, if xclip is available
if command -v xclip >/dev/null 2>&1; then
  alias pbcopy='xclip -selection clipboard -rmlastnl'
  alias pbpaste='xclip -selection clipboard -o'
fi

if [[ "$(uname -s)" == "Linux" ]] && command -v dpkg >/dev/null 2>&1; then
  if dpkg -l | grep -q ubuntu-wsl; then
  #################
  # Ubuntu on WSL #
  #################
    pgrep gpg-agent >/dev/null 2>&1 || eval $(gpg-agent --daemon --quiet)

    # Like MacOS
    alias pbcopy="clip.exe"
    alias pbpaste="powershell.exe -command 'Get-Clipboard' | tr -d '\r'"
  fi
fi

# Set Terraform plugin cache
export TF_PLUGIN_CACHE_DIR="${HOME}/.terraform.d/plugin-cache"

# Jira
if command -v jira &> /dev/null; then
  eval "$(jira --completion-script-zsh)"
fi

# I use ctrl+d to scroll down in kitty, ignore accidentally closing
# my terminal window
set -o ignoreeof

# KDE
if command -v ksshaskpass >/dev/null 2>&1; then
  export SSH_ASKPASS="/usr/bin/ksshaskpass"
  export SSH_ASKPASS_REQUIRE="prefer"
fi

# shellenv contains non-sensitive per-device configuration
test -f ~/.shellenv && source ~/.shellenv

# Secret contains sensitive per-device configuration
test -f ~/.secretenv && source ~/.secretenv

# Load aliases at the end
source ~/.dotfiles/aliases

# Source zoxide at the end of configuration
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi
