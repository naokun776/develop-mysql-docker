# develop-mysql-docker

開発用にちゃらっとMySQL 5.6を使う。パスワード設定は無い。

## 使い方

1. bundleされたMySQLのRPMファイルをダウンロードしてdockerディレクトリに配置する。
1. DockerfileのMYSQL_VERSIONの値をダウンロードしたファイルのバージョンに合わせる。
1. sh build-docker.shでコンテナイメージをビルドする
1. sh run-docker.shでコンテナを起動する。

supervisorを利用してバックグラウンド実行するにはdaemon-docker.shを使う。