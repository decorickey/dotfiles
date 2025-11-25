# AGENTS

## リポジトリ概要

- MacOS 向け dotfiles。`./setup.sh` を入口に各種開発ツールと設定を自動適用する。
- コア処理は `scripts/` 以下に分割され、`logging.sh` で統一的なログ、`common.sh` でシンボリックリンクやコマンド確認などを提供。
- Neovim (LazyVim)・VSCode NeoVim 連携・tmux・Volta・AI ガイダンス (Claude / Codex / Gemini) をまとめて管理する。

## セットアップの流れ

- 推奨コマンドは `./setup.sh`。`--list` で利用可能ステップの確認、`--only <step ...>` で指定ステップのみ実行、`--skip <step ...>` でスキップ指定。
- デフォルト実行順序: `packages → shell → git → go → neovim → tmux → volta → claude → codex → gemini → vscode`。
- 実行ログは `setup.log` に追記されるため、失敗時はここを参照。

### Quick start

```bash
./setup.sh
./setup.sh --only neovim tmux
./setup.sh --skip claude codex
```

## ステップ詳細

### packages (`scripts/packages.sh`)

- OS を判定して Homebrew を導入し、PATH 設定まで自動化。
- `Brewfile` を `brew bundle` で処理し、git / tmux / neovim / go など主要ツールを一括インストール。
- インストール後に欠けている主要コマンドがあれば警告を出す。

### shell (`scripts/shell.sh`)

- git を前提に Oh My Zsh と fzf を非対話モードで導入。
- `~/.zshrc` に fzf 既定オプション、Go / Volta PATH、各種 alias を追記。
- fzf の再読込やシェル再起動の案内を表示。

### git (`scripts/git.sh`)

- `core.editor=nvim`、`init.defaultBranch=main` 等のグローバル設定を適用。
- `.gitmessage.txt` をコミットテンプレートとして紐付け、`git lg` など alias 群も追加。
- ユーザー名 / メール未設定の場合は設定コマンドを案内。

### go (`scripts/go.sh`)

- `GOBIN` を明示 (`$HOME/go/bin` を既定) し、PATH に未登録なら追加。コメントで「未指定でも GOPATH/bin だが固定する」旨を明記。
- `gopls` / `delve` は `go install ...@latest` でインストール・更新。
- `golangci-lint` は Homebrew でインストール・更新する。
- Go / curl が無い場合は packages ステップ再実行を案内し、各ツールのバージョンをログ出力。

### neovim (`scripts/neovim.sh`)

- 既存の Neovim キャッシュ・設定ディレクトリをクリーンアップ。
- `lazyvim/` を `~/.config/nvim` へリンクし、`.vimrc` を IdeaVim と共有 (`~/.ideavimrc`)。
- 初回起動時の Lazy.nvim プラグイン導入や `:LazySync` / `:checkhealth` の案内を出力。

### tmux (`scripts/tmux.sh`)

- `.tmux.conf` をホームへリンクし、tmux の存在を検証。
- 既存セッション向けに `tmux source-file ~/.tmux.conf` 等の再読込手順を提示。

### volta (`scripts/volta.sh`)

- Volta の有無を判定し、必要ならインストールスクリプトを実行。
- `VOLTA_HOME` と PATH を `.zshrc` に追記し、`volta list` などで検証。
- `volta install node@latest` など使用例を示す。

### claude (`scripts/claude.sh`)

- `~/.claude` を作成し、`CLAUDE.md` / `settings.json` / `agents` / `commands` を dotfiles からリンク。
- それぞれのリンク状態を検証し、利用可能なファイル一覧を案内。

### codex (`scripts/codex.sh`)

- `~/.codex/AGENTS.md` に Codex 向けグローバルガイダンスをリンク。
- `config.toml` があれば同様にリンクし、検証ログとファイル一覧を表示。

### gemini (`scripts/gemini.sh`)

- `~/.gemini/GEMINI.md` をリンクし、Gemini CLI のガイダンスを共有。
- ディレクトリとシンボリックリンクの検証を行う。

### vscode (`scripts/vscode.sh`)

- `code` コマンドの有無をチェックし、なければインストール手順を案内。
- `vscode/settings.json` と `vscode/keybindings.json` を VSCode User ディレクトリにリンク。
- `.vimrc` の VSCode 対応設定を確認し、NeoVim 拡張 (`asvetliakov.vscode-neovim`) の導入を促す。

## 共通ユーティリティ

- `scripts/common.sh`: コマンド存在確認、シンボリックリンク作成、ディレクトリ作成など。
- `scripts/logging.sh`: INFO / WARN / ERROR / SUCCESS を色付きで表示するロガー。
- `scripts/os.sh`: Homebrew のインストール先などを OS ごとに切り替える。
- `scripts/shell_utils.sh`: `.zshrc` への PATH 追記や環境変数設定を支援。

## 付属ドットファイル

- `.vimrc`: Neovim / IdeaVim / VSCode NeoVim 拡張で共通利用する設定。
- `.zshrc`: 履歴設定、fzf 連携、Go / Volta PATH、git / docker 向け alias。
- `.tmux.conf`: プレフィックス `Ctrl-q`、Vim ライクなペイン操作、ステータスライン調整。
- `.markdownlint.yaml`: Markdown Lint の無効化ルール (MD012 / MD013 / MD028 / MD041)。

## ディレクトリ構成 (抜粋)

```text
dotfiles/
├── setup.sh             # 全体セットアップのエントリーポイント
├── scripts/             # 各セットアップ処理と共通ユーティリティ
├── lazyvim/             # Neovim (LazyVim) 設定
├── vscode/              # VSCode の設定とキーバインド
├── .claude/ .codex/ .gemini/ # AI アシスタント向けガイダンス
├── Brewfile             # Homebrew で導入するツール一覧
└── setup.log            # セットアップログ (実行時に生成)
```

## トラブルシューティング

- ステップごとの詳細ログは `setup.log` を確認。
- Homebrew / Volta の PATH が反映されない場合は新しいシェルを開くか `source ~/.zshrc` を実行。
- VSCode の設定ディレクトリが存在しない場合は一度 VSCode を起動してから再実行。
