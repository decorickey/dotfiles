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

# Git
export PATH=/usr/local/bin/git:$PATH
git config --global core.editor "nvim"
git config --global push.autoSetupRemote true

# NeoVim
alias -g vim="nvim"
alias -g view="nvim -R"

# Go
export PATH="$HOME/go/bin:$PATH"

# Volta
export PATH="$HOME/.volta/bin:$PATH"

# fzf
source <(fzf --zsh)

# fzf - git
alias -g lb='`git branch           | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
alias -g ab='`git branch --all     | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
alias -g rb='`git branch --remotes | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
alias -g mb='`git branch --merged  | grep -v HEAD | fzf +m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'
 
# fzf - docker
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
alias -g cid='`docker ps | sed 1d | fzf -q "$1" | awk '\''{print $1}'\''`'
