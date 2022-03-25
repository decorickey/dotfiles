# dotfiles

## Macのセットアップ

### システム環境設定

* デフォルトのWebブラウザ：Google Chrome
* スクリーンセーバ：30分で開始、時計と一緒に表示
* ホットコーナー：四隅でスクリーンセーバ開始
* Dock：自動的に表示/非表示
* メニューバー：表示する項目、バッテリーの割合、時計の表示方法
* キーボード：キーのリピート、リピート入力認識までの時間、修飾キー（CapsLock）、ショートカット（Mission Control）
* トラックパッド：適宜
* マウス：適宜
* バッテリー：ディスプレイオフの調整（バッテリー：デフォルト、電源アダプタ：オフにしない）

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

