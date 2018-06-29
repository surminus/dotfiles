# Path to your oh-my-zsh installation.
echo "Loading zsh config"
export ZSH=/Users/$USER/.oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

echo "Setting editor"
export EDITOR=vim
alias vim='/usr/local/bin/vim'

echo "Loading zsh theme"
ZSH_THEME="robbyrussell"
test -f ~/.oh-my-zsh/custom/themes/surminus.zsh-theme && ZSH_THEME="surminus"

echo "Unbundling commands"
export UNBUNDLED_COMMANDS=(kitchen foodcritic bundler)

echo "Setting zsh plugins"
plugins=(
  bundler
  capistrano
  emoji
  git
  github
  golang
  iterm2
  j
  kubectl
  osx
  pass
  rake
  ruby
  vagrant
  zsh-autosuggestions
  zsh-completions
)

echo "Autoload for zsh completion"
autoload -U compinit && compinit

echo "Setting paths"
# Go
export GOPATH="$HOME/go"
export PATH=$PATH:$(go env GOPATH)/bin
# Set path
export PATH="/usr/local/Cellar:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"
# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# gnu
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

echo "Loading rbenv"
# rbenv
eval "$(rbenv init -)"

echo "zsh final load"
source $ZSH/oh-my-zsh.sh

echo "Loading aliases"
source ~/.dotfiles/config/aliases

echo "Loading completions"
source ~/.dotfiles/config/completions

echo "Setting diff"
test -f /usr/local/bin/colordiff && source ~/.dotfiles/config/diff
