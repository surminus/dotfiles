# Path to your oh-my-zsh installation.
export ZSH=/Users/paulmartin/.oh-my-zsh
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

export EDITOR=vim
export VAGRANT_GOVUK_NFS=no

ZSH_THEME="robbyrussell"

plugins=(osx git bundler rake ruby vagrant pass j)

export PATH="bin:/opt/boxen/rbenv/shims:/opt/boxen/rbenv/bin:/opt/boxen/ruby-build/bin:/opt/boxen/homebrew/bin:/opt/boxen/homebrew/sbin:/opt/boxen/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munki"

export HOMEBREW_GITHUB_API_TOKEN="79dbc9390ef8064bf82f31a60240202f8c660b71"

source $ZSH/oh-my-zsh.sh

alias govuk="cd ~/govuk"

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
