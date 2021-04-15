class PurchasesController < ApplicationController
  def index
    @purchase_destination = PurchaseDestination.new
    @item = Item.find_by(id:params[:item_id])
  end

  def new
    @purchase_destination = PurchaseDestination.new

  end
  
  def create
    @item = Item.find_by(id:params[:item_id])
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
    params.require(:purchase_destination).permit(:zip_code, :prefecture_id, :municipality, :address, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
  end
end
