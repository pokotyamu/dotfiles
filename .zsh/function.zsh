function git(){hub "$@"}

#peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
	tac="tac"
    else
	tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
		    eval $tac | \
		    peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-src () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
	BUFFER="cd ${selected_dir}"
	zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# emacs (GUI)
function emacs () {
   EMACS_CLIENT='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
   EMACS='/Applications/Emacs.app'

   [ 0 -eq $# ] && _ARGV=. || _ARGV=$*

   if pgrep Emacs > /dev/null; then
     $EMACS_CLIENT -n $_ARGV
   else
     open -a $EMACS $_ARGV
   fi
}

# emacs -nw
function emacsnw () {
  EMACS_CLIENT='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
  EMACS='/Applications/Emacs.app/Contents/MacOS/Emacs'

  if ! pgrep Emacs > /dev/null; then
    $EMACS --daemon
  fi

  [ 0 -eq $# ] && _ARGV=. || _ARGV=$*

  $EMACS_CLIENT -nw -q $_ARGV
}
alias emacsn='emacsnw'
alias nemacs='emacsnw'

function ekill () {
  pkill Emacs
}

function gemacs () {
  EMACS_CLIENT='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
  $EMACS_CLIENT -c -q
}