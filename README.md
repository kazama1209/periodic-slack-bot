# periodic-slack-bot

指定のSlackチャンネルへ予め設定した間隔または時間帯にメッセージを投稿するbot。

自分の場合、毎日業務終了後は日報を書く事になっているのだが、毎回日報ページを開きに行くのが面倒なので平日19時にURLを自分のチャンネルへ自動で飛ばすようにした。

## セットアップ（ローカル環境）

### Rubyのバージョン指定

```
$ rbenv local 2.5.1

# 本リポジトリはRuby2.5.1で作成しているが、それぞれ任意のバージョンでOK。
```

### .envの作成やbundle installなどの初期設定

```
$ make init 

# 各自環境変数をセット。
```

### SlackBotの起動
```
$ make run

# 定期処理の実行間隔はconfig/clock.rb内で設定可能。
```

## Herokuへのデプロイ（本番環境）

### ログイン

```
$ heroku login --interactive

Email [******************@gmail.com]: 
Password: **********
Logged in as ******************@gmail.com

# 各ログイン情報を入力。
```

### Herokuアプリを作成

```
$ heroku create [app_name]

https://app_name.herokuapp.com/ | https://git.heroku.com/app_name.git

# 任意のアプリ名を入力
```

### Herokuへプッシュ

```
$ git add .
$ git commit -m 'deploy for Heroku'
$ git push heroku master

Enumerating objects: 17, done.
Counting objects: 100% (17/17), done.
Delta compression using up to 12 threads
Compressing objects: 100% (14/14), done.
Writing objects: 100% (17/17), 2.99 KiB | 62.00 KiB/s, done.
Total 17 (delta 0), reused 0 (delta 0), pack-reused 0
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Ruby app detected
remote: -----> Installing bundler 2.1.4
remote: -----> Removing BUNDLED WITH version in the Gemfile.lock
remote: -----> Compiling Ruby
remote: -----> Using Ruby version: ruby-2.5.1
remote: -----> Installing dependencies using bundler 2.1.4
remote:        Running: BUNDLE_WITHOUT='development:test' BUNDLE_PATH=vendor/bundle BUNDLE_BIN=vendor/bundle/bin BUNDLE_DEPLOYMENT=1 bundle install -j4
remote:        Fetching gem metadata from https://rubygems.org/......
remote:        Fetching thread_safe 0.3.6
remote:        Fetching minitest 5.14.2

---中略---

remote: 
remote: -----> Compressing...
remote:        Done: 19.1M
remote: -----> Launching...
remote:        Released v4
remote:        https://app_name.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/app_name.git
 * [new branch]      master -> master
```

### 環境変数をセット

```
$ heroku config:set SLACK_BOT_TOKEN=value SLACK_USER_ID=value SLACK_CHANNEL_NIPPO=value SLACK_CHANNEL_TEST=value NIPPO_URL=value

Setting SLACK_BOT_TOKEN, SLACK_USER_ID, SLACK_CHANNEL_NIPPO, SLACK_CHANNEL_TEST, NIPPO_URL and restarting ⬢ app_name... done, v5

NIPPO_URL:           https://*********
SLACK_BOT_TOKEN:     xoxb-*******************
SLACK_CHANNEL_NIPPO: #******
SLACK_CHANNEL_TEST:  #******
SLACK_USER_ID:       *********


# valueには各値を入れる。
```

### アプリを起動

```
$ heroku ps:scale worker=1

Scaling dynos... done, now running worker at 1:Free
```

### ログを確認

```
$ heroku logs -t 

Scaled to console@0:Free rake@0:Free worker@1:Free by user *********@gmail.com
2020-10-09T17:33:32.592223+00:00 heroku[worker.1]: Starting process with command `bundle exec clockwork config/clock.rb`
2020-10-09T17:33:33.303946+00:00 heroku[worker.1]: State changed from starting to up
2020-10-09T17:33:37.483182+00:00 app[worker.1]: I, [2020-10-10T02:33:37.482999 #4]  INFO -- : Starting clock for 2 events: [ nippo test ]
2020-10-09T17:33:37.654622+00:00 app[worker.1]: I, [2020-10-10T02:33:37.654493 #4]  INFO -- : Triggering 'test'

# 上手く行った場合はSlackに「送信テスト」というメッセージが飛ぶはず。
# もしエラーが発生していた場合はログに沿ってデバッグ。
```

### アプリを停止

```
$ heroku ps:scale worker=0
```
