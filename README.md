# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Ruby version
- 2.4.1

## データベース
[ridgepole](https://github.com/winebarrel/ridgepole)を使っている。
```bash
$ ridgepole -c config/database.yml --apply -E developement
```
- test DB
```bash
$ ridgepole -c config/database.yml --apply -E test
```

- seed
seed_fuを使っている
```
# マスタデータ。最初に実行すれば良い。
bin/rake db:seed_fu FIXTURE_PATH=./db/fixtures/masters
# 開発用データ
bin/rake db:seed_fu FIXTURE_PATH=./db/fixtures/development
```

## その他
### rubocop
[ここを参考](https://qiita.com/kyohei_shimada/items/e739dec967eb5e61721c)にrubocop導入
```
$ rubocop -Rc .rubocop.yml
```

* Deployment instructions

* ...
