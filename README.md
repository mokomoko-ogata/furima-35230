# テーブル設計

## users テーブル

| Column                      | Type         | Options                   |
| --------------------------- | ------------ | ------------------------- |
| nickname                    | string       | null: false               |
| email                       | string       | null: false, unique: true |
| encrypted_password          | string       | null: false               |
| last_name                   | string       | null: false               |
| first_name                  | string       | null: false               |
| last_name_pronounce         | string       | null: false               |
| first_name_pronounce        | string       | null: false               |
| birthday                    | date         | null: false               |

### Association

- has_many :items
- has_many :comments
- has_many :purchases

## items テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| item_name                   | string       | null: false                    |
| explain                     | text         | null: false                    |
| category_id                 | integer      | null: false                    |
| condition_id                | integer      | null: false                    |
| delivery_charge_id          | integer      | null: false                    |
| from_id                     | integer      | null: false                    |
| shipping_date_id            | integer      | null: false                    |
| price                       | integer      | null: false                    |
| user                        | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one :purchase

## purchases テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| user                        | references   | null :false, foreign_key: true |
| item                        | references   | null :false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :destination

## Destinations テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| zip_code                    | string       | null :false                    |
| prefecture_id               | integer      | null :false                    |
| municipality                | string       | null :false                    |
| address                     | string       | null :false                    |
| building_name               | string       |                                |
| telephone_number            | string       | null :false                    |
| purchase                    | references   | null :false, foreign_key: true |

### Association

- belongs_to :purchase

## Comments テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| text                        | text         | null :false                    |
| user                        | references   | null :false, foreign_key: true |
| item                        | references   | null :false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item