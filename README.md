# ItemStock

フリマ出品における「在庫・出品状況の管理が煩雑になる問題」を解決するために開発した、個人向けアイテム管理アプリです。

🔗 Live Demo  
https://itemstock.onrender.com/

## 🌐 アプリ概要

ItemStock は、個人でフリマアプリを利用する際に発生する

* 在庫の把握ができない
* 出品状況が分からなくなる
* 売却履歴を管理しづらい

といった課題を解決するために開発しました。

「アイテム管理を、もっとシンプルに」をコンセプトに設計しています。


## 主な機能

### 🔐 ユーザー機能

* ユーザー登録 / ログイン（Devise）
* ゲストログイン
* プロフィール編集


### 📦 アイテム管理

* アイテムCRUD機能
* 画像アップロードにはRails ActiveStorageを使用し、
本番環境ではAmazon S3に保存する構成を採用
* メモ・詳細情報保存
* ステータス管理

  * 出品前
  * 出品中
  * 売却済み
    

### 📊 ダッシュボード

* ステータス別件数表示
* 売却状況の可視化
  
### ☁️ インフラ構成
本番環境はRender + AWS S3 + PostgreSQLで構成しています。

### 🎨 UI / UX

* シンプルで直感的なUI設計
* favicon / アプリアイコン実装


## 🛠 技術スタック

| Category        | Technology         |
| --------------- | ------------------ |
| Backend         | Ruby on Rails 7    |
| Authentication  | Devise             |
| Database        | PostgreSQL(本番環境)|
|                 | / SQLite3(開発環境) |
| Image Upload    | ActiveStorage      |
|                 | Amazon S3(本番環境) |         
| Frontend        | HTML / CSS         |
| Environment     | Docker             |
| Version Control | Git / GitHub       |


## 🧱 ER図
![ER図](images/er_ItemStock.png)


## 🚀 セットアップ方法

```bash
git clone https://github.com/miraisato-dev/ItemStock.git
cd ItemStock
bundle install
rails db:create db:migrate
rails s
```

ブラウザで以下にアクセス：

```
http://localhost:3000
```



## 👤 ゲストログイン

ログイン画面から **ゲストログイン** を利用することで、アカウント登録なしで機能を確認できます。


## 🎯 開発背景

フリマアプリ利用時に、出品状況や在庫管理が煩雑になる経験から、

* シンプルに管理できること
* 状態を一目で把握できること

を重視して開発しました。


## 💡 工夫した点

* ステータス管理を enum で実装し可読性を向上
* ダッシュボードで情報を一画面に集約
* 採用担当者が確認しやすいようゲストログインを実装
* シンプルで直感的に操作でき、一目で機能が理解できるUI設計を意識しました。

## 🔮 今後の改善予定

* テスト追加
* 入力コストの最小化としてバーコードスキャン機能(Google Books APIとの連携)
* 定型文テンプレート: 「裁断済み」「美品」など、状況に合わせた説明文を1タップで生成
* UI/UX改善
* 通知機能追加
* AIによる価格提案機能
* 売上データのグラフ可視化
* 全体的なデザインの向上
* 登録時の速度が遅い
* 一覧にしたときに行のどこをクリックしても反応するように
* レスポンシブ対応にする

## 📸 スクリーンショット

* トップページ
![top](images/top.png)
* ダッシュボード
![dashboard](images/dashboard.png)
* アイテム一覧
![dashboard](images/list.png)
* アイテム詳細
![detail](images/detail.png)
* ログイン画面
![login](images/login.png)

## Updates

### 2026/05/13
①商品画像のサムネイル切り替え処理を jQuery から Vanilla JavaScript に変更
- 画像クリック時のメイン画像反映ラグを改善
- Turbo 環境下でのイベント処理を安定化
② 商品登録画面・編集画面での画像並び替えUI改善
- 既存画像同士の並び替えのみ可能だった問題を改善
- 新規追加画像と既存画像を相互にドラッグ＆ドロップできるよう修正
- app/javascript/image_upload.js に existingContainer を追加し、SortableJS の group 設定を行うことで複数コンテナ間の移動に対応
③商品編集画面で画像を並び替えた際にDBでも並び替えられるようになった
- 商品編集画面で画像をドラッグ＆ドロップで並び替えた際、表示順だけでなくDB側の position も更新されるよう改善
- フロント側の並び順変更に合わせて、item_images テーブルの順序情報を保存する処理を実装
- 再読み込み後も並び順が保持されるように対応


## 👨‍💻 作者

miraisato-dev
GitHub: https://github.com/miraisato-dev
