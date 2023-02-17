# dotfiles

## AppStore

* 1Password
* Bear
* Slack

## アプリケーション

* Google Chrome
  * デフォルトに設定
* Raycast
* Logi Options
* Visual Studio Code
* JetBrains Toolbox
* Docker Desktop

## 開発ツール（必須）

### Homebrew

* https://brew.sh/index_ja

### oh-my-zsh

* https://ohmyz.sh/

```bash
# oh-my-zshにより自動生成された.zshrcからカスタマイズ.zshrcを読み込む
source ~/dotfiles/.zshrc
```

### Node.js(Volta)

* https://volta.sh/

### fzf

* https://github.com/junegunn/fzf

### Vim/NeoVim

```bash
brew install vim
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

## 開発ツール（補助）

### gitのプラグイン

* https://github.com/tpope/vim-fugitive
  * neovimだとインストール先が違うので注意
* https://github.com/tpope/vim-commentary
  * neovimだとインストール先が違うので注意
* https://github.com/airblade/vim-gitgutter
