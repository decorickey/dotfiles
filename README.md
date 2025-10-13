# dotfiles

macOS / Ubuntu の開発環境を `./setup.sh` で一括セットアップする dotfiles リポジトリです。

## Quick start

```bash
./setup.sh          # 既定ステップを順番に実行
./setup.sh --list   # 実行可能ステップを確認
./setup.sh --only neovim tmux   # 必要なものだけ実行
```

セットアップログは `setup.log` に出力されます。

## Manual installs

- Google Chrome
- Google日本語入力
- iTerm2
- Raycast
- 1Password
- JetBrains Toolbox
- Docker Desktop

## More details

各ステップの挙動や構成ファイルの説明は `AGENTS.md` を参照してください。
