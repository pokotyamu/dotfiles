export ZSH=/Users/pokotyamu/.oh-my-zsh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

ZSH_THEME="miloshadzic"

plugins=(git ruby rails)

source $ZSH/oh-my-zsh.sh

export SCALA_HOME=/usr/local/share/scala-2.11.4
export PATH=$PATH:$SCALA_HOME/bin
export PATH=/usr/texbin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export EDITOR='/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs -nw '
#nodebrew
export PATH=/usr/local/bin/nodebrew/current/bin:$PATH

PATH="$PATH:/usr/local/jruby/bin"

#rbenv
[[ -d ~/.rbenv  ]] && \
    export PATH=${HOME}/.rbenv/bin:${PATH} && \
      eval "$(rbenv init -)"

export M3_HOME=/usr/local/apache-maven-3.3.3
M3=$M3_HOME/bin
export PATH=$M3:$PATH

RPROMPT="%T" # 右側に時間表示
setopt transient_rprompt # 右側まで入力がきたら時間表示を消す

# 補完
#for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit # 補完機能
compinit -u

compinit -u # 補完を賢くする
setopt autopushd # cdの履歴表示、cd - で一つ前のディレクトリへ
setopt pushd_ignore_dups # 同ディレクトリを履歴に追加しない
setopt auto_cd # ディレクトリ名のみでcd
setopt list_packed # リストを詰めて表示
setopt list_types # 補完一覧をファイル種別に表示
setopt correct # コマンドのスペルチェックを有効に



# 名前で色を付けるようにする
autoload colors
colors

# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# terminal のタイトルに「ユーザ@ホスト:カレントディレクトリ」と表示
case "${TERM}" in
    kterm*|xterm)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        ;;
esac

#histroyに時間を付ける
HIST_STAMPS="mm/dd/yyyy"

#alias
alias emacs='/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs -nw '
alias rab='rabbit'
alias sshkit='ssh -l o675022e remote-i.isc.kyutech.ac.jp'
alias geeknote='/usr/local/bin/geeknote'
alias el='elixir'
alias sudo="sudo env PATH=$PATH"
alias be='bundle exec'
alias mi="mvn install"
alias fsw="foreman start web"

#alias git関係
alias gco='git checkout'
alias gb='git branch'
alias gbd='git branch -d'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcm='git commit -m'
alias gc='git commit'
alias gs='git status'
alias gaa='git add -A'
alias gau='git add -u'
alias gl='git log --graph --oneline --decorate --date=short'


export PATH="/usr/local/bin:$PATH"
export ARCHFLAGS="-arch x86_64"
export PGDATA="/usr/local/var/postgres"


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
