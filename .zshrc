plugins=(git ruby rails)
source ~/.zsh/all.zsh

# 名前で色を付けるようにする
autoload colors
colors

# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


#direnv
eval "$(direnv hook zsh)"

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

alias s='ssh $(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config|peco|awk "{print \$2}")'
