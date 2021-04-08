# テーブル設計

## users テーブル

| Column                      | Type         | Options                |
| --------------------------- | ------------ | ---------------------- |
| nickname                    | string       | null: false            |
| email                       | string       | null: false            |
| password                    | string       | null: false            |
| last_name                   | string       | null: false            |
| first_name                  | string       | null: false            |
| birthday                    | datetime     | null: false            |

### Association

- has_many :items
- has_many :comments
- has_many :purchases

## items テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| item_name                   | string       | null: false                    |
| explain                     | text         | null: false                    |
| category                    | string       | null: false                    |
| condition                   | string       | null: false                    |
| delivery_charge             | string       | null: false                    |
| from                        | string       | null: false                    |
| shipping_date               | string       | null: false                    |
| price                       | integer      | null: false                    |
| user_id                     | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one :purchase

## purchases テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| card_number                 | integer      | null: false                    |
| validated_date              | datetime     | null: false                    |
| security_code               | integer      | null :false                    |
| user_id                     | references   | null :false, foreign_key: true |
| item_id                     | references   | null :false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :destination

## Destinations テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| zip_code                    | integer      | null :false                    |
| prefecture                  | string       | null :false                    |
| municipality                | string       | null :false                    |
| address                     | string       | null :false                    |
| building_name               | string       |                                |
| telephone_number            | integer      | null :false                    |
| purchase_id                 | references   | null :false, foreign_key: true |

### Association

- belongs_to :purchase

## Comments テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| text                        | text         | null :false                    |
| user_id                     | references   | null :false, foreign_key: true |
| item_id                     | references   | null :false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item