# テーブル設計

## users テーブル

| Column                | Type   | Options                   |
| ----------------------| ------ | ------------------------- |
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| password              | string | null: false               |
| password_confirmation | string | null: false               |
| full_name             | string | null: false               |
| full_name_kana        | string | null: false               |
| date_of_birth         | string | null: false               |


### Association

- has_many :prototypes
- has_many :comments

## products テーブル

| Column | Type   | Options                                     |
| ----------- | -------------- | ------------------------------ |
| user        | references     | null: false, foreign_key: true |
| image       | text           | null: false                    |
| name         | string        | null: false, limit: 40         |
| description  | text          | null: false, limit: 1000       |
| price       | DECIMAL(10, 2) | null: false                    |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column    | Type       | Options           |
| --------- | ---------- | ----------------- |
| user      | references | foreign_key: true |
| product   | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :delivery

## deliveries テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| purchase     | references | null: false, foreign_key: true |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     |                                |
| phone_number | string     | null: false                    |

### Association

- belongs_to :purchase
