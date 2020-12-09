class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
# ↑の記述がある限り未ログインユーザーはログインページへ飛ばされる インデックスは除いてあげたい
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index_order

  def index
    @transaction = Transaction.new
    if @item.user.id == current_user.id || @item.order !=nil #もしくは 売れている場合→ordersテーブルにレコードがある
      redirect_to root_path
    end
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
      amount: set_item[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index_order
    @item = Item.find(params[:item_id])
    if @item.order.present?
      redirect_to root_path
    end
  end

end
