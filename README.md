# テーブル設計


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