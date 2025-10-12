# AGENTS

## リポジトリ概要
- macOS/Ubuntu 用 dotfiles リポジトリ。`setup.sh` から各種セットアップスクリプトを統一的に実行し、開発環境を構築する。
- コアスクリプトは `scripts/` 以下にあり、`logging.sh` と `common.sh` がシンボリックリンク作成やログ出力などの共通機能を提供する。
- Neovim/LazyVim 設定、VSCode NeoVim 連携、tmux、Volta、Claude Code/Codex のパーソナルガイダンスなどをまとめて管理する。

## セットアップの流れ
- 推奨コマンドは `./setup.sh`。  
  - `--list` で利用可能ステップを表示。  
  - `--only <step ...>` で指定ステップのみを実行。  
  - `--skip <step ...>` で指定ステップを飛ばす。
- デフォルト実行順序: `packages → shell → git → neovim → tmux → volta → claude → codex → gemini → vscode`。
- 各スクリプトはホームディレクトリへのシンボリックリンク作成と導入後の簡易検証まで行い、ログは `setup.log` に追記される。

## 主な構成要素
- **Homebrew (`scripts/packages.sh`)**  
  - `Brewfile` に記載された git/tmux/neovim/go などのコマンドラインツールを `brew bundle` で一括導入。  
  - Homebrew 未導入時は OS 判定 (`scripts/os.sh`) に基づきインストールと PATH 設定を行う。
- **シェル (`scripts/shell.sh`)**  
  - Oh My Zsh と fzf を非対話インストール。`~/.zshrc` には fzf の既定オプション、Go/Volta の PATH 追記、便利 alias が含まれる。
- **Git (`scripts/git.sh`)**  
  - グローバル設定（`core.editor=nvim`、`init.defaultBranch=main` 等）とコミットテンプレート (`.gitmessage.txt`) の関連付け。
- **Neovim (`scripts/neovim.sh`)**  
  - `lazyvim/` ディレクトリを `~/.config/nvim` にリンクし、`.vimrc` を共通設定として読み込み。  
  - Neovim 初回起動時に Lazy.nvim がプラグインを自動インストール。Treesitter/LSP は Lua & Go を中心に構成。
- **tmux (`scripts/tmux.sh`)**  
  - `~/.tmux.conf` にリンク。プレフィックス `Ctrl-q`、Vim ライクなペイン操作、ステータス調整などを適用。
- **Volta (`scripts/volta.sh`)**  
  - Volta の取得・PATH 設定・簡易確認までを自動化。Node/Yarn などは必要に応じ手動で `volta install`。
- **VSCode (`scripts/vscode.sh`)**  
  - VSCode がインストール済みかつ `code` コマンドが使える前提で、`vscode/` 内の設定・キーバインドを `~/Library/Application Support/Code/User` へリンク。  
  - NeoVim 拡張 (`asvetliakov.vscode-neovim`) の導入を促す。
- **AI ガイダンス**
  - Claude Code 向け設定 (`scripts/claude.sh`)：`~/.claude` にグローバル指示、コマンド定義、通知フックをリンク。  
  - Codex 向け個人ガイダンス (`scripts/codex.sh`)：`~/.codex/AGETNTS.md` に指示（常に日本語、作業前に計画提示）を反映。
  - Gemini CLI 向け個人ガイダンス (`scripts/gemini.sh`)：`~/.gemini/GEMINI.md` をリンクし、Gemini との作業指針を共有。

## 付属ドットファイル
- `.vimrc`：NeoVim/IdeaVim/VSCode NeoVim 拡張で共通利用するキーマップと基本オプション。
- `.zshrc`：履歴設定、fzf ロード、Go/Volta PATH、fzf を使った git/docker 操作用 alias。
- `.tmux.conf`：プリフィックス・配色・コピー操作などのカスタマイズ。
- `.markdownlint.yaml`：Markdown Lint の無効化ルール（MD012/MD013/MD028/MD041）を定義。
