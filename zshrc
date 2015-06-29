# Path to your oh-my-zsh installation.
export ZSH=/Users/paulmartin/.oh-my-zsh
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

export EDITOR=vim

ZSH_THEME="robbyrussell"

plugins=(git bundler osx rake ruby vagrant)

export PATH="bin:/opt/boxen/rbenv/shims:/opt/boxen/rbenv/bin:/opt/boxen/ruby-build/bin:/opt/boxen/homebrew/bin:/opt/boxen/homebrew/sbin:/opt/boxen/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munki"

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
