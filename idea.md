毎日の開発を楽しくする

with Qiita

開発

- エディタ
- コーディング
- 詰まったところを解決 (ノウハウ)

Qiita
- ノウハウ投稿
  - まとめるの結構大変
- 閲覧
  - パブリックタイムライン
  - タグ
  - 検索
  - フォロー関係
- コメント

Qiita team
- あまり使い込んでないのでよくわからない?
- パブリックよりは気軽に投稿できる

投稿
- 開発したら投稿になるシステム?
- 再生もできる
- Literate CoffeeScript + requirebin みたいなの

- JavaScriptで書いたコード (コメント付き) からQiita投稿を生成
- 生成されたQiita投稿を再生 (実行)
- DOM要素をスクリーンショット

```javascript
/*
# pathでパスを繋げる

Node.js (browserify) ではpathモジュールを使ってパスをつなぐことができる。
*/

var path = require('path');
path.join('foo/bar', 'baz') //=>

/*
@screenshot('#main', {after: 10000})
*/
```

- esprimaを使ってコメント抽出
- `/* */`の内容ははMarkdown
- `//=>`は前の行の評価結果を自動的に挿入
- `//`はコードコメント

- browserify-cdnを使ってバンドル
- ブラウザ上で実行
  - node-webkitとかでもいいかも (nodeのコードも実行できる)
- html2canvasでスクリーンショット
