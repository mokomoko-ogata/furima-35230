class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :zip_code, :prefecture_id, :municipality, :address, :building_name, :telephone_number, :item_id, :user_id, :purchase_id, :token

  with_options presence: true do
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality
    validates :address
    validates :telephone_number, numericality: { only_integer: true }, length: { in: 10..11 }
    validates :user_id
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Destination.create(zip_code: zip_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building_name: building_name, telephone_number: telephone_number, purchase_id: purchase.id)
  end
end