#alias
alias emacs='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'
alias e='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'
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

#peco 用
alias s='ssh $(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config|peco|awk "{print \$2}")'