class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index_order

  def index
    @transaction = Transaction.new
    redirect_to root_path if @item.user.id == current_user.id || !@item.order.nil? # もしくは 売れている場合→ordersテーブルにレコードがある
  end

  def create
    @transaction = Transaction.new(order_params)
    if @transaction.valid?
      pay_item
      @transaction.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number, :token).merge(user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index_order
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.order.present?
  end
end
