export ZSH=/Users/pokotyamu/.oh-my-zsh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR='/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs '

# go lang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin


# nodebrew
export PATH=/usr/local/bin/nodebrew/current/bin:$PATH

# rbenv
[[ -d ~/.rbenv  ]] && \
    export PATH=${HOME}/.rbenv/bin:${PATH} && \
      eval "$(rbenv init -)"
export PATH="/usr/local/bin:$PATH"
export ARCHFLAGS="-arch x86_64"
export PGDATA="/usr/local/var/postgres"
