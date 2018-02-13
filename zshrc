# Path to your oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR=vim
alias vim='/usr/local/bin/vim'

export VAGRANT_GOVUK_NFS=no

if [ -e ~/.oh-my-zsh/themes/robbyrussell-custom.zsh-theme ]; then
  ZSH_THEME="robbyrussell-custom"
else
  ZSH_THEME="robbyrussell"
fi

plugins=(
  bundler
  cf
  emoji
  git
  github
  golang
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

export GOPATH="$HOME/go"
export PATH="${HOME}/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"

eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh

# Custom aliases
alias vi=vim
alias bim=vim

# Bundle aliases
alias bi="bundle install --path ~/.bundle"
alias be="bundle exec"

# Pass Aliases
alias pass-fetch="pass git pull"
alias pass-push="pass git push"
alias pass-sync="pass-fetch && pass-push"

# Vagrant Aliases
alias vup="vagrant up"
alias vd="vagrant destroy --force"
alias vp="vagrant provision"
alias vssh="vagrant ssh"

# Git Aliases
alias gco="git checkout"
alias gcm="git checkout master && git pull"
alias gpr="git push origin head && git pr"

export TERRAGOV_CONFIG_FILE=~/.terragov.yml
