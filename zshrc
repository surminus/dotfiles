# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Use vim
export EDITOR=vim

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
  pass
  rake
  ruby
  terraform
  ubuntu
  zsh-autosuggestions
)

autoload -U compinit && compinit

bindkey '^ne' edit-command-line
bindkey '^n^e' edit-command-line

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
export ABLYCTL_PAGER="less -XFR"

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# secret
test -f ~/.secret && source ~/.secret

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

#########
# MacOS #
#########
if [[ "$(uname -s)" == "Darwin" ]]; then
  # gnu tools
  export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

  test -f /usr/local/bin/vim && alias vim='/usr/local/bin/vim'
fi

# Like MacOS, if xclip is available
if command -v xclip >/dev/null 2>&1; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

##########
# Ubuntu #
##########
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

# Load aliases at the end
source ~/.dotfiles/aliases

# Finally load tmux
if [[ -z $TMUX ]]; then tmux attach; fi
