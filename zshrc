# Path to your oh-my-zsh installation.
export ZSH=/Users/paulmartin/.oh-my-zsh
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

export EDITOR=vim

ZSH_THEME="robbyrussell"

plugins=(git bundler osx rake ruby vagrant)

export PATH="bin:/opt/boxen/rbenv/shims:/opt/boxen/rbenv/bin:/opt/boxen/ruby-build/bin:/opt/boxen/homebrew/bin:/opt/boxen/homebrew/sbin:/opt/boxen/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munki"

source $ZSH/oh-my-zsh.sh

# Vagrant Aliases
alias vup="vagrant up"
alias vd="vagrant destroy"
alias vp="vagrant provision"
alias vssh="vagrant ssh"
alias vs="vagrant status |grep running"

# Git Aliases
alias gco="git checkout"
alias gp="git pull"
alias gcm="git checkout master && git pull"
