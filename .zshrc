# vim alias
alias -g vim="nvim"
alias -g view="nvim -R"

# basic settings
setopt no_beep # 音を鳴らさない

# history settings
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups     # 直前と同じコマンドは追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除
setopt share_history        # 履歴を共有する
setopt inc_append_history   # コマンド実行後即座に履歴保存
setopt append_history       # 履歴に追加保存
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks   # 余分な空白は詰めて保存

# fzf functions
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# git alias
# alias -g lb='`git branch           | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
# alias -g ab='`git branch --all     | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
# alias -g rb='`git branch --all     | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
# alias -g rb='`git branch --remotes | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
# alias -g mb='`git branch --merged  | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
 
# docker
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
alias -g cid='`docker ps | sed 1d | fzf -q "$1" | awk '\''{print $1}'\''`'

# pycacheディレクトリを作成しない
export PYTHONDONTWRITEBYTECODE=1

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Golang
export PATH="$HOME/go/bin:$PATH"
