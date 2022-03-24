# oh-my-zsh設定
plugins=(web-search fzf)

# エイリアス
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# zsh基本設定
setopt no_beep # 音を鳴らさない

# history設定
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

# ブランチをgitコマンドの引数にわたす（peco）
alias -g lb='`git branch    | grep -v HEAD | sed "s/*//g" | sed "s/ //g" | sed "s/remotes\/origin\///g" | sort -u | peco `'
alias -g rb='`git branch -a | grep -v HEAD | sed "s/*//g" | sed "s/ //g" | sed "s/remotes\/origin\///g" | sort -u | peco `'

