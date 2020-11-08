# README

# データベース設計
 ## usersテーブル
| Colomn                 |Type    | Option |
-------------------------|--------|-------------
|nickname               | string | NOT NULL |
|email                  | string | NOT NULL |
|encrypted_password    | string | NOT NULL  |
|first_name            | string | NOT NULL  |
|family_name           | string | NOT NULL  |
|first_name_kana        | string | NOT NULL |
|family_name_kana       | string | NOT NULL |
|birthday                | date   | NOT NULL|

### Association
- has_many :products
- has_many :buyers


## products テーブル

Column              | Type | Option
--------------------|------|--------------
name                   | string  | null: false
description            |  text   | null: false
price                  | integer | null: false
category_id            | integer | null: false ,foreign_key: true
status_id              | integer | null: false ,foreign_key: true
shipment_prefecture_id | integer | null: false ,foreign_key: true
date_of_shipment_id    | integer | null: false ,foreign_key: true
delivery_fee_id        | integer | null: false ,foreign_key: true
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