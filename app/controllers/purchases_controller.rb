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
      @purchase_destination.save
      redirect_to root_path  
    else
      render :index
    end
  end

  private
  def purchase_params
    params.require(:purchase_destination).permit(:hoge, :zip_code, :prefecture_id, :municipality, :address, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
end
