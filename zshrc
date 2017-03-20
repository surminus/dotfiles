# Path to your oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR=vim
export VAGRANT_GOVUK_NFS=no

if [ -e ~/.oh-my-zsh/themes/robbyrussell-custom.zsh-theme ]; then
  ZSH_THEME="robbyrussell-custom"
else
  ZSH_THEME="robbyrussell"
fi

plugins=(osx git github bundler rake ruby vagrant pass j emoji cf)

export GOPATH="$HOME/.go"
export PATH="${HOME}/.rbenv/shims:/usr/local/Cellar:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"

eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh

# Custom aliases
alias govuk="cd ~/govuk"
alias vi=vim
alias bim=vim

# Pass Aliases
alias pass-fetch="pass git pull"
alias pass-push="pass git push"

# Bundle aliases
alias bi="bundle install --path ~/.bundle"
alias be="bundle exec"

# Pass Aliases
alias pass-fetch="pass git pull"
alias pass-push="pass git push"

# Vagrant Aliases
alias vup="vagrant up"
alias vd="vagrant destroy --force"
alias vp="vagrant provision"
alias vssh="vagrant ssh"
alias vs="echo 'Checking what machines are running' && vagrant status |grep running"

# Git Aliases
alias gco="git checkout"
alias gp="git pull"
alias gcm="git checkout master && git pull"
