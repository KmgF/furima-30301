# README

# データベース設計
 ## usersテーブル
| Colomn                 |Type    | Option |
-------------------------|--------|-------------
|nickname               | string | null: false|
|email                  | string |null: false |
|encrypted_password    | string | null: false |
|first_name            | string | null: false  |
|family_name           | string | null: false |
|first_name_kana        | string | null: false |
|family_name_kana       | string | null: false |
|birthday                | date   | null: false|

### Association
- has_many :products
- has_many :buyers


## products テーブル

Column              | Type | Option
--------------------|------|--------------
name                   | string  | null: false
description            |  text   | null: false
price                  | integer | null: false
category_id            | integer | null: false
status_id              | integer | null: false
shipment_prefecture_id | integer | null: false
date_of_shipment_id    | integer | null: false
delivery_fee_id        | integer | null: false
user_id                | integer | null: false ,foreign_key: true 

### Association
- belongs_to :user
- has_one :buyer

## buyers テーブル
Column      | Type    | Option
------------|---------|------------------------------
user_id     | integer | null: false , foreign_key: true
product_id  | integer | null: false , foreign_key: true
address_id  | integer | null: false

### Association
- belongs_to :user
- belongs_to :product
- has_one :address


## addressesテーブル
Column         | Type    | Opion
---------------|---------|---------------
post_number    | string  | null: false
prefecture_id  | integer | null: false
city           | string  | null: false
postal_code    | string  | null: false
building_name  | string  |
tel            | string | null: false
buyer_id       | integer | null:false ,foreign_key: true

### Association
 - belongs_to :buyer