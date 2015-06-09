# github hook のテスト

## 開発環境で起動
gitコマンドが正常に動作してくれるか確認する。

```bash
$ bundle install
$ REPOSITORY_ROOT=repository_root_path ruby myapp.rb
```

### 動作テスト

正常系

```bash
$ curl -F 'payload={"repository": {"name": "hoge"}}' http://localhost:4567/github
```

同時起動の場合

```bash
$ curl -F 'payload={"repository": {"name": "hoge"}}' http://localhost:4567/github; curl -F 'payload={"repository": {"name": "hoge"}}' http://localhost:4567/github
```

## githubでの設定
Webhookの設定を以下のようにすること。
* Payload URLを設定
* Content typeを`application/x-www-form-urlencoded`に設定
* webhookのトリガーとなるイベントを`Just the push event`に設定

Webhookの設定ページ下部に`Recent Deliveries`があり、webhookの際のリクエストとレスポンスが残っている。
