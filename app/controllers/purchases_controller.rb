class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index_for_current, only: [:index, :new, :create]
  before_action :move_to_index_for_user, only: [:index, :new, :create]

  def index
    @purchase_destination = PurchaseDestination.new
  end

  def new
    @purchase_destination = PurchaseDestination.new
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
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
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end

  def move_to_index_for_current
    redirect_to root_path if user_signed_in? && current_user.id == @item.user_id
  end

  def move_to_index_for_user
    redirect_to root_path if user_signed_in? && @item.purchase.present?
  end
end
