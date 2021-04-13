class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :zip_code, :prefecture, :municipality, :address, :building_name, :telephone_number, :item_id, :user_id

  with_options presence: true do
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality
    validates :address
    validates :telephone_number, numericality: {with: /\A\d{11}+\z/}
    validates :item_id
    validates :user_id
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Destination.create(zip_code: zip_code, prefecture: prefecture, municipality: municipality, address: address, building_name: building_name, telephone_number: telephone_number, purchase_id: purchase.id)
  end
end