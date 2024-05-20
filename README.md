# テーブル設計

## users テーブル

| Column                | Type   | Options                   |
| ----------------------| ------ | ------------------------- |
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false               |
| last_name             | string | null: false               |
| first_name            | string | null: false               |
| last_name_kana        | string | null: false               |
| first_name_kana       | string | null: false               |
| date_of_birth         | date   | null: false               |

### Association

- has_many :products
- has_many :purchases

## products テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| name            | string     | null: false, limit: 40         |
| description     | text       | null: false, limit: 1000       |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| delivery_cost   | string     | null: false                    |
| delivery_region | string     | null: false                    |
| delivery_days   | string     | null: false                    |
| price           | integer    | null: false                    |

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

| Column        | Type       | Options                        |
| ------------ -| ---------- | ------------------------------ |
| purchase      | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| city          | string     | null: false                    |
| address_line1 | string     | null: false                    |
| address_line2 | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to :purchase
