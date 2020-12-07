class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item,only: [:index, :create]
 
  def index
    @transaction = Transaction.new
    if @item.user.id == current_user.id
      redirect_to root_path
    end 
  end

  def create
    @transaction = Transaction.new
    if @transaction.valid?
      @transaction.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  private

  def order_params
    params.permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number, :token).merge(user_id: current_user.id,item_id: @item.id)
  end
end
