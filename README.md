# README

# データベース設計
 ## usersテーブル
Colomn                 |Type    | Option
-----------------------------
nickname               | string | NOT NULL
email                  | string | NOT NULL
encrypted_password    | string | NOT NULL
first_name            | string | NOT NULL
family_name           | string | NOT NULL
first_name_kana        | string | NOT NULL
family_name_kana       | string | NOT NULL
birthday                | date   | NOT NULL

### Association
- has_many :products


## products テーブル

Column              | Type | Option
------------------------------
name                   | string  | NOT NULL
message                |  text   | NOT NULL
price                  | integer | NOT NULL
category_id            | integer | NOT NULL
status_id              | integer | NOT NULL
shipment_prefecture_id | integer | NOT NULL
date_of_shipment_id    | integer | NOT NULL
delivery_fee_id        | integer | NOT NULL
user                   | references|

### Association
- belongs_to :user
- has_one :buyer

## buyers テーブル
Column      | Type    | Option
-------------------------------
user_id     | integer | NOT NULL , foreign_key: true
product_id  | integer | NOT NULL , foreign_key: true
address_id  | integer | NOT NULL,  foreign_key: true

### Association
- belongs_to :product
- has_one :address


 ### Association
- belongs_to :buyer

## addressesテーブル
Column         | Type    | Opion
---------------------------------------
post_number    | string  | NOT NULL
prefecture_id  | integer | NOT NULL
city           | string  | NOT NULL
postal_code    | string  | NOT NULL
building_name  | string  |

tel         | string | NOT NULL

### Association
 - belongs_to :buyer