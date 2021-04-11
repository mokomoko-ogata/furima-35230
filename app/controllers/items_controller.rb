class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]  
  def index
    @items = Item.order("created_at DESC")
  end

  def new
  end
end
