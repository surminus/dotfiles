# Path to your oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR=vim
export VAGRANT_GOVUK_NFS=no

if [ -e ~/.oh-my-zsh/themes/robbyrussell-custom.zsh-theme ]; then
  ZSH_THEME="robbyrussell-custom"
else
  ZSH_THEME="robbyrussell"
fi

plugins=(osx git bundler rake ruby vagrant pass j emoji cf)

export GOPATH=/opt/boxen/homebrew/Cellar/go/1.6
export PATH="bin:/opt/boxen/rbenv/shims:/opt/boxen/rbenv/bin:/opt/boxen/ruby-build/bin:/opt/boxen/homebrew/bin:/opt/boxen/homebrew/sbin:/opt/boxen/bin:/usr/local/Cellar:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/munki:$GOPATH/bin"

export HOMEBREW_GITHUB_API_TOKEN="79dbc9390ef8064bf82f31a60240202f8c660b71"

source $ZSH/oh-my-zsh.sh

# Custom aliases
alias govuk="cd ~/govuk"
alias vi=vim
alias bim=vim

# Pass Aliases
alias pass-fetch="pass git pull"
alias pass-push="pass git push"

# Vagrant Aliases
alias vup="vagrant up"
alias vd="vagrant destroy"
alias vp="vagrant provision"
alias vssh="vagrant ssh"
alias vs="echo 'Checking what machines are running' && vagrant status |grep running"

# Git Aliases
alias gco="git checkout"
alias gp="git pull"
alias gcm="git checkout master && git pull"

source '/opt/boxen/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
source '/opt/boxen/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
