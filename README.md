# github hook を使って、リポジトリをミラーリングしたい

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

# 設置

## ミラーリング対象をクローン
```bash
$ cd (リポジトリを置くディレクトリ)
$ git clone --mirror (ミラーリング対象のリポジトリURL)
```

## githubでの設定
ミラーリング対象のリポジトリでWebhookの設定を以下のようにすること。
* Payload URLを設定
* Content typeを`application/x-www-form-urlencoded`に設定
* webhookのトリガーとなるイベントを`Just the push event`に設定

Webhookの設定ページ下部に`Recent Deliveries`があり、webhookの際のリクエストとレスポンスが残っている。

## サーバの起動

```
$ REPOSITORY_ROOT=(リポジトリを置いているディレクトリ) bundle exec rackup -D -p (ポート番号) -s thin -o 0.0.0.0
```

## テスト

テストに使っても良いリポジトリで…
新しいブランチで変更を行い、githubへプッシュしてみる。

```
NUMBER=105; git checkout master; git checkout -b "test${NUMBER}"; echo "test${NUMBER}" >> README.md; git commit -a -m "test${NUMBER}"; git push origin "test${NUMBER}"
```

サーバ上で

```
$ git --git-dir=(リポジトリを置いているディレクトリ)/(リポジトリ名).git branch
# pushしたブランチができていればOK
```
