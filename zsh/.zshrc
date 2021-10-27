# 色を使用
autoload -Uz colors
colors

# デフォルトのプロンプト設定
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

## history検索強化（peco）
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

