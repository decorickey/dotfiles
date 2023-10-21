# dotfiles

## AppStore

* Slack

## アプリケーション

* 1Password 8
* Google日本語入力
* Google Chrome
* warp/iterm2
* Raycast
* Visual Studio Code
* JetBrains Toolbox
* Docker Desktop
* Logi Options
* Xmind

## 開発ツール

### [Homebrew](https://brew.sh/index_ja)

### [Oh My Zsh](https://ohmyz.sh/)

```bash:.zshrc
ZSH_THEME="kolo"

source ~/dotfiles/.zshrc
```

### [Node.js(Volta)](https://volta.sh/)

### NeoVim

```bash
brew install neovim
```

.gitconfigに以下を追記

```
[core]
  editor = nvim
```

### [AstroNvim](https://docs.astronvim.com/)

init.luaの先頭に追記

```
vim.cmd('source ~/dotfiles/.vimrc')
if vim.g.vscode then return end
```

### [fzf](https://github.com/junegunn/fzf)

### [cfn-lint](https://github.com/aws-cloudformation/cfn-lint)

### Python

Homebrew経由でインストール

