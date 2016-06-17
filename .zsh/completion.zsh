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

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
