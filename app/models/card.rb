class Card < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :card_token
    validates :customer_token
    # validates :user_id
  end
end
