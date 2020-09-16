# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column   | Type   | Options                        |
| -------- | ------ | ------------------------------ |
| nickname | string | null: false                    |
| email    | string | null: false, uniqueness : true |
| password | string | null: false, uniqueness : true |

### Association

- has_many :items
- has_many :orderedItems
- has_one :profiles

## profiles テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| last_name       | string     | null: false                    |
| first_name      | string     | null: false                    |
| last_name_kana  | string     | null: false                    |
| first_name_kana | string     | null: false                    |
| date_of_birth   | date       | null: false                    |

### Association

- belongs_to :users

## items テーブル

| Column        | Type        | Options                        |
| ------------- | ----------- | ------------------------------ |
| user          | references  | null: false, foreign_key: true |
| item_name     | string      | null: false                    |
| price         | integer     | null: false,                   |
| seller        | string      | null: false,                   |
| image_url     | text        | null: false,                   |
| description   | text        | null: false,                   |
| category_id   | integer     | null: false,                   |
| condition_id  | integer     | null: false,                   |
| handling_id   | integer     | null: false,                   |
| postage_id    | integer     | null: false,                   |
| prefecture_id | integer     | null: false,                   |

### Association

- belongs_to :users
- has_one :orderedItems

## orderedItems テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- has_one :addresses

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| item          | references | null: false, foreign_key: true |
| post_code     | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building_name | string     | null: false                    |
| phone_number  | string     | null: false, uniqueness: true  |

### Association

- belongs_to :orderedItems