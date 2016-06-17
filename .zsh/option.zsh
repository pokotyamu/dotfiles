ZSH_THEME="miloshadzic"
source $ZSH/oh-my-zsh.sh

RPROMPT="%T" # 右側に時間表示
setopt transient_rprompt # 右側まで入力がきたら時間表示を消す

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
