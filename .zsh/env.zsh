export ZSH=/Users/pokotyamu/.oh-my-zsh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"

# Python
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

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
