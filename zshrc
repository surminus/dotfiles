# Path to your oh-my-zsh installation.
echo -n $'#             (5%)\r'
export ZSH=/Users/$USER/.oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

echo -n $'##            (10%)\r'
export EDITOR=vim
alias vim='/usr/local/bin/vim'

echo -n $'###           (15%)\r'
ZSH_THEME="robbyrussell"
test -f ~/.oh-my-zsh/custom/themes/surminus.zsh-theme && ZSH_THEME="surminus"

echo -n $'####          (20%)\r'
export UNBUNDLED_COMMANDS=(kitchen foodcritic bundler)

echo -n $'#####         (24%)\r'
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

echo -n $'######        (32%)\r'
autoload -U compinit && compinit

echo -n $'#######       (39%)\r'
# Node 8.x
export PATH="/usr/local/opt/node@8/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH=$PATH:$(go env GOPATH)/bin
# Set path
export PATH="/usr/local/Cellar:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"
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

export AWS_REGION=eu-west-1

echo -n $'########      (52%)\r'
# rbenv
eval "$(rbenv init -)"

echo -n $'#########     (60%)\r'
source $ZSH/oh-my-zsh.sh

echo -n $'##########    (72%)\r'
source ~/.dotfiles/config/aliases

echo -n $'############  (82%)\r'
source ~/.dotfiles/config/completions

echo -n $'############# (99%)\r'
test -f /usr/local/bin/colordiff && source ~/.dotfiles/config/diff
