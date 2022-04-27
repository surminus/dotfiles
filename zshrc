# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Use vim
export EDITOR=vim

ZSH_THEME="robbyrussell"
test -f ~/.oh-my-zsh/custom/themes/surminus.zsh-theme && ZSH_THEME="surminus"

plugins=(
  aws
  docker
  emoji
  fzf
  github
  golang
  node
  pass
  rake
  ruby
  ubuntu
  zsh-autosuggestions
)

autoload -U compinit && compinit

# Go
if test -d ~/.goenv; then
  # goenv
  export GOENV_ROOT="$HOME/.goenv"
  export PATH=$GOENV_ROOT/bin:$PATH
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH=$GOPATH/bin:$PATH
fi

# Home bin
export PATH="$HOME/bin:$PATH:"

# autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=238
export TERM="xterm-256color"

# hub
if [ -e /usr/local/bin/hub ]; then
  eval "$(hub alias -s)"
  if [ -e ~/.zsh/completions/_hub ]; then
    fpath=(~/.zsh/completions $fpath)
    autoload -U compinit && compinit
  fi
fi

# rbenv
if test -d $HOME/.rbenv; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
  fi
fi

if command -v bundle >/dev/null 2>&1; then
  test -d $HOME/.bundle || mkdir -p $HOME/.bundle
  if ! test -f $HOME/.bundle/config || ! grep -q BUNDLE_PATH $HOME/.bundle/config; then
    bundle config set --local path "$HOME/.bundle"
  fi
fi

# tfenv
if test -d $HOME/.tfenv; then
  export PATH="$HOME/.tfenv/bin:$PATH"
fi

# pyenv
if test -d $HOME/.pyenv; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
  fi
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
fi

# nodenv
if test -d $HOME/.nodenv; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

# cargo
test -d $HOME/.cargo/bin && export PATH="$HOME/.cargo/bin:$PATH"

# awscli v2
export AWS_PAGER="less -XFR"

# GitHub CLI
export GH_PAGER="less -XFR"

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# secret
test -f ~/.secret && source ~/.secret

# pulumi
if test -d $HOME/.pulumi; then
  export PATH=$HOME/.pulumi/bin:$PATH
fi

# toolkit
if test -d ~/surminus/toolkit; then
  export PATH=$HOME/surminus/toolkit:$PATH
fi

# Search (fzf and fd)
#
# If installed using apt, then it may be called fdfind
if command -v fdfind >/dev/null 2>&1; then
  FD_COMMAND="fdfind"
elif command -v fd >/dev/null 2>&1; then
  FD_COMMAND="fd"
fi

# I like fd, but the globbing zsh behaviour
# means it doesn't work so well
[[ -n $FD_COMMAND ]] && alias fd="noglob ${FD_COMMAND}"

if test -d $HOME/.fzf; then
  if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
  fi

  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null
  source "$HOME/.fzf/shell/key-bindings.zsh"

  [[ -n $FD_COMMAND ]] && export FZF_DEFAULT_COMMAND="${FD_COMMAND} --type f --hidden --follow --exclude '.git'"
fi

# Enable pass extensions
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

#########
# MacOS #
#########
if [[ "$(uname -s)" == "Darwin" ]]; then
  # gnu tools
  export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

  test -f /usr/local/bin/vim && alias vim='/usr/local/bin/vim'
fi

# Like MacOS, if xclip is available
if command -v xclip >/dev/null 2>&1; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

##########
# Ubuntu #
##########
if [[ "$(uname -s)" == "Linux" ]] && command -v dpkg >/dev/null 2>&1; then
  if dpkg -l | grep -q ubuntu-wsl; then
  #################
  # Ubuntu on WSL #
  #################
    pgrep gpg-agent >/dev/null 2>&1 || eval $(gpg-agent --daemon --quiet)

    # Like MacOS
    alias pbcopy="clip.exe"
    alias pbpaste="powershell.exe -command 'Get-Clipboard' | tr -d '\r'"
  fi
fi

# Load aliases at the end
source ~/.dotfiles/aliases

# Update mychef if we need to
if test -f ~/.chef/mychef/lastrun; then
  if [[ $(find ~/.chef/mychef/lastrun -mtime +30 |wc -l) -gt 0 ]]; then
    echo "WARNING: mychef has not been run in 30 days, run now? y/n"
    read ANSWER

    case $ANSWER in
      y|Y)
        cd ~/.chef/mychef

        if [[ $(git rev-parse --abbrev-ref HEAD) == 'master' ]]; then
          echo "On master branch, attempting update..."
          git pull origin master
        fi

        mychef
        cd $HOME
        ;;

      *) echo "OK, will ignore for another 30 days" && touch ~/.chef/mychef/lastrun;;
    esac
  fi
fi
