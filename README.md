# README

# データベース設計
 ## userテーブル
Colomn      |Type    | Option
-----------------------------
nickname   | string | NOT NULL
email       | string | NOT NULL
password    | string | NOT NULL
first_name  | string | NOT NULL
family_name | string | NOT NULL
first_name_kana | string | NOT NULL
family_name_kana | string | NOT NULL
birthday    | date   | NOT NULL

### Association
- has_many :products


## products テーブル

Column              | Type | Option
------------------------------
name                | string | NOT NULL
message             | string | NOT NULL
price               | integer | NOT NULL
category            | string | NOT NULL
status              | string | NOT NULL
shipment_prefecture | string | NOT NULL
date_of_shipment    | string | NOT NULL
delivery_fee        | integer | NOT NULL
user_id             | references   |
image               |ActiveStorageで実装

### Association
- belongs_to :user
- has_one :buyer

## buyer テーブル
Column     | Type | Option
-------------------------------
credit_card_id  | integer | NOT NULL
adress_id  | integer | NOT NULL

### Association
- belongs_to :products
- has_one :credit_card
- has_one :adress

## credit テーブル
Column      | Type  | Option
-------------------------------------
card_number | integer | NOT NULL
expiration_date | date | NOT NULL
seurity_number | integer | NOT NULL

 ### Association
- belongs_to :buyer

## adressテーブル
Column   | Type | Opion
---------------------------------------
post-number | integer | NOT NULL
prefecture  | string  | NOT NULL
city        | string  | NOT NULL
street_adress | string | NOT NULL
tel         | integer | NOT NULL

### Association
 - belongs_to :buyer