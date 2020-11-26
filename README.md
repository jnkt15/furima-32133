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
| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | string | null: false |

- has_many :items

## items テーブル
| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item_name        | string     | null: false                    |
| price            | integer    | null: false                    |
| text             | text       | null: false                    |
| category         | integer    | null: false                    |
| condition        | integer    | null: false                    |
| delivery_fee     | integer    | null: false                    |
| shipping_area    | integer    | null: false                    |
| shipping_date    | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |

- belongs_to :user
- has_one :address

## address テーブル
| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefectur       | integer    | null: false                    | 
| municipality    | string     | null: false                    |
| address         | string     | null: false                    |
| building_name   | string     | null: false                    |
| phone_number    | string     | null: false                    |
| order_id        | references | null: false, foreign_key: true |

- belongs_to :user