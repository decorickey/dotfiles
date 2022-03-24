# dotfiles

## Macのセットアップ

### AppStore

* (1Password)
* Slack
* CotEditor
* Magnet or Rectangle
  * Rectangleは公式サイトから

### その他アプリケーション

* Google Chrome
* Google日本語入力
* iTerm2
* Alfred
  * AppStore版もあるがアップデートされていない上に機能が少ない
* Authy
* Clipy
* Visual Studio Code
* JetBrains Toolbox
* Docker Desktop
* Logi Options
* (AppCleaner)

### Homebrew

時間かかるので注意

* https://brew.sh/index_ja

### Vim/NeoVim/Peco

```bash
brew install vim
brew install neovim
brew install peco
```

### fzf

* https://github.com/junegunn/fzf
  * brewでもインストールできるがgitでインストールしたほうがいい

### oh-my-zsh

* https://ohmyz.sh/

```bash
# oh-my-zshにより自動生成された.zshrcからカスタマイズ.zshrcを読み込む
source ~/dotfiles/.zshrc
```

## Vim

### Vim Plug

* https://github.com/junegunn/vim-plug

### gitのプラグイン

* https://github.com/tpope/vim-fugitive
  * neovimだとインストール先が違うので注意
* https://github.com/tpope/vim-commentary
  * neovimだとインストール先が違うので注意
* https://github.com/airblade/vim-gitgutter

### 複数行コメント（gc）


