# dotfiles

## AppStore

* 1Password
* Bear
* Slack

## アプリケーション

* Google Chrome
* warp or iterm2
* Raycast
* Visual Studio Code
* JetBrains Toolbox
* Docker Desktop
* Logi Options

## 開発ツール（必須）

### Homebrew

* https://brew.sh/index_ja

### Node.js(Volta)

* https://volta.sh/

### NeoVim

```bash
brew install neovim
```

.gitconfigに以下を追記

```
[core]
  editor = nvim
```

### VimPlug

* https://github.com/junegunn/vim-plug
 * coc.nvimを利用するためにnode.jsが必要

### fzf

* https://github.com/junegunn/fzf

## 開発ツール（補助）

### oh-my-zsh（iterm2の場合）

* https://ohmyz.sh/

```bash
# oh-my-zshにより自動生成された.zshrcからカスタマイズ.zshrcを読み込む
source ~/dotfiles/.zshrc
```
