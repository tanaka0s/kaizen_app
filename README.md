# アプリケーション名
Innovation

# アプリケーションの概要
社内で業務改善を行いやすくするアプリです。改善提案を投稿し、社員に共有できます。一覧ページから実施できそうな業務改善を探し、実施した内容を投稿できます。これまでに行ってきた業務改善を記録として残せます。業務改善によって削減できた工数とコストを確認できます。

--URL--  
https://kaizen-app-innovation.herokuapp.com/

# テスト用アカウント
・ Basic認証ID : kyoto  
・ Basic認証パスワード : 9999  
・ メールアドレス : test@test.com  
・ パスワード : a12345  

# 利用方法
①ログイン  
・ログイン画面でテスト用アカウントを使ってログインもしくは、ゲストログインをクリックし、ゲストユーザーでログイン  
②改善提案の投稿  
・ヘッダーの「投稿する」ボタンをクリック  
・新規投稿ページで改善提案の内容を入力し、「投稿する」をクリック  
③改善提案の実施  
・投稿した改善提案にある「実施」ボタンをクリック  
・実施した改善提案の内容を入力し、「投稿する」をクリック  

# アプリケーションを作成した背景
前職で業務改善を行っていた際に、不便に感じていたことを解決するためにこのアプリケーションを作成しました。具体的には、①業務改善を思いついても忙しくて実施する時間がない。②これまでにこの会社では、どのような業務改善が行われてきたか分からない。という不便さを感じていました。①を解決するために業務改善の提案者と実施者を分けられるようにしました。②を解決するために実施した業務改善をアプリケーションに記録し、一覧画面から閲覧できるようにしました。

# 工夫した点
・年間削減工数と年間削減コストをユーザーが数値を入力すると自動的に計算されるようにしたこと

・削減コストが高い順にソートできるようにしたことで、実施すべき業務改善を探しやすくしたこと

・これまで実施した業務改善の削減工数と削減コストの合計値を表示することで、社員全員で積み重ねてきた成果を見える化したこと

・一覧ページで改善提案のタイトルのみ表示し、クリックするとアコーディオン形式で詳細が表示されるようにしたこと

# 要件定義

[こちらから](https://docs.google.com/spreadsheets/d/1aS1AcYL37TOMkTVHraLD-KmpTGn4IxBHTWTSB9Ycu6A/edit#gid=982722306)

# 実施予定の機能
現在、結合テストコードを記述中  
今後は、非同期通信を用いたコメント投稿機能を実装予定  

# テーブル設計

![ER](https://user-images.githubusercontent.com/109464303/187062932-adc4f972-41d4-40eb-8b62-be96d564acd6.png)

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| name               | string | null: false               |

### Association

- has_many :proposals
- has_many :executions

## proposals テーブル

| Column             | Type          | Options                        |
| ------------------ | ------------- | ------------------------------ |
| user               | references    | null: false, foreign_key: true |
| title              | string        | null: false                    |
| where              | text          | null: false                    |
| what               | text          | null: false                    |
| why                | text          | null: false                    |
| how                | text          | null: false                    |
| before_seconds     | integer       | null: false                    |
| before_workers     | integer       | null: false                    |
| before_days        | integer       | null: false                    |
| before_man_hours   | decimal(10,1) | null: false                    |
| hourly_wage        | integer       | null: false                    |
| before_costs       | integer       | null: false                    |

### Association

- belongs_to :user
- has_one    :estimation
- has_one    :execution

## estimations テーブル

| Column             | Type          | Options                        |
| ------------------ | ------------- | ------------------------------ |
| proposal           | references    | null: false, foreign_key: true |
| after_seconds      | integer       | null: false                    |
| after_workers      | integer       | null: false                    |
| after_days         | integer       | null: false                    |
| after_man_hours    | decimal(10,1) | null: false                    |
| hourly_wage        | integer       | null: false                    |
| after_costs        | integer       | null: false                    |
| reduced_man_hours  | decimal(10,1) | null: false                    |
| reduced_costs      | integer       | null: false                    |

### Association

- belongs_to :proposal

## executions テーブル

| Column             | Type          | Options                        |
| ------------------ | ------------- | ------------------------------ |
| user               | references    | null: false, foreign_key: true |
| proposal           | references    | null: false, foreign_key: true |
| where              | text          | null: false                    |
| what               | text          | null: false                    |
| why                | text          | null: false                    |
| how                | text          | null: false                    |
| after_seconds      | integer       | null: false                    |
| after_workers      | integer       | null: false                    |
| after_days         | integer       | null: false                    |
| after_man_hours    | decimal(10,1) | null: false                    |
| hourly_wage        | integer       | null: false                    |
| after_costs        | integer       | null: false                    |
| reduced_man_hours  | decimal(10,1) | null: false                    |
| reduced_costs      | integer       | null: false                    |

### Association

- belongs_to :user
- belongs_to :proposal

# 画面遷移図

![display](https://user-images.githubusercontent.com/109464303/187066940-21b9a2a6-a0f4-435c-b7f1-99cca8ddd4b8.png)

# 開発環境
・フロントエンド  
&emsp;HTML,CSS,JavaScript  
・バックエンド  
&emsp;Ruby on Rails(Ruby)  
・データベース  
&emsp;MySQL  
・インフラ  
&emsp;AWS(S3)  
・OS  
&emsp;Mac  
・テキストエディタ  
&emsp;Visual Studio Code  
・タスク管理  
&emsp;Github