# Go

## 基本ルール

- Go公式の標準ライブラリが提供している機能を最優先で利用してください。
- パッケージ外に公開している識別子にはすべてコメントを記述してください。
  - interfaceをimplementしているだけの型やメソッドなら、`Hoge implements hogeImpl`のようにコメントを記述してください。
- エラーメッセージは小文字で記述してください。
- テストはTable Driven Testで記述してください。

## エラーハンドリング

- `fmt`, `errors`パッケージを使用してください。
- `github.com/pkg/errors`, `golang.org/x/xerrors`は使用しないでください。
