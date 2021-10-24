alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# デフォルトのプロンプト
PROMPT="%{${fg[green]}%}[%n@%m:%~]
$ %{${reset_color}%}"

# git情報をプロンプトに表示
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示
precmd () { vcs_info }
setopt prompt_subst
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# tab補完候補をハイライト
autoload -Uz compinit && compinit
compinit
zstyle ':completion:*:default' menu select=2

# fzfを使えるようにする
source ~/.fzf.zsh

# コマンド履歴関連
HISTFILE=~/.zsh_history      # ヒストリファイルを指定
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録

# ブランチをgitコマンドの引数にわたす（peco）
alias -g lb='`git branch    | grep -v HEAD | sed "s/*//g" | sed "s/ //g" | sed "s/remotes\/origin\///g" | sort -u | peco `'
alias -g rb='`git branch -a | grep -v HEAD | sed "s/*//g" | sed "s/ //g" | sed "s/remotes\/origin\///g" | sort -u | peco `'

# ctrl + rで履歴検索（peco）
function peco-history-selection() {
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
zle -N peco-history-selection
bindkey '^r' peco-history-selection
