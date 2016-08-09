export ZSH=/Users/pokotyamu/.oh-my-zsh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'

# go lang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# rbenv
[[ -d ~/.rbenv  ]] && \
    export PATH=${HOME}/.rbenv/bin:${PATH} && \
      eval "$(rbenv init -)"
export PATH="/usr/local/bin:$PATH"
export ARCHFLAGS="-arch x86_64"
export PGDATA="/usr/local/var/postgres"

#direnv
eval "$(direnv hook zsh)"

#nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
