class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchase_destination = PurchaseDestination.new
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to new_card_path
    else 
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_token)
      @default_card = customer.cards.first
    end
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    redirect_to new_card_path and return unless current_user.card.present?
    if @purchase_destination.valid?
      pay_item
      @purchase_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_destination).permit(:zip_code, :prefecture_id, :municipality, :address, :building_name, :telephone_number).merge(
      user_id: current_user.id, item_id: @item.id
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end

  def move_to_index
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase.present?
  end
end
