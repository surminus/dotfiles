# Path to your oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR=vim
alias vim='/usr/local/bin/vim'

export VAGRANT_GOVUK_NFS=no

if [[ -f ~/.oh-my-zsh/custom/themes/surminus.zsh-theme ]]; then
  ZSH_THEME="surminus"
else
  ZSH_THEME="robbyrussell"
fi

plugins=(
  bundler
  emoji
  git
  github
  golang
  iterm2
  j
  osx
  pass
  rake
  ruby
  vagrant
  zsh-autosuggestions
  zsh-completions
)

autoload -U compinit && compinit

# Go
export GOPATH="$HOME/.go"
# Set path
export PATH="${HOME}/.rbenv/shims:/usr/local/Cellar:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"
# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# gnu
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh
source ~/.dotfiles/config/aliases

test -f ~/surminus/to-do/to-do.completion && source ~/surminus/to-do/to-do.completion
