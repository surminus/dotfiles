export ZSH=/Users/$USER/.oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim
export EDITOR=vim
alias vim='/usr/local/bin/vim'

# theme
ZSH_THEME="robbyrussell"
test -f ~/.oh-my-zsh/custom/themes/surminus.zsh-theme && ZSH_THEME="surminus"

# plugins
export UNBUNDLED_COMMANDS=(kitchen foodcritic bundler)

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

# Bash completion compatability
autoload -U compinit && compinit

# Node 8.x
export PATH="/usr/local/opt/node@8/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH=$PATH:$(go env GOPATH)/bin

# Set path
export PATH="/usr/local/Cellar:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"

# Terralearn
if test -d ~/futurelearn/futurelearn-terraform/bin; then
  export PATH="$PATH:$HOME/futurelearn/futurelearn-terraform/bin"
fi

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# Set MySQL client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# gnu
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
# rbenv
eval "$(rbenv init -)"

# zsh
source $ZSH/oh-my-zsh.sh

# aliases
source ~/.dotfiles/config/aliases

# completions
source ~/.dotfiles/config/completions

# diff
test -f /usr/local/bin/colordiff && source ~/.dotfiles/config/diff
