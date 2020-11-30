class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  private

  def items_params
    params.require(:item).permit(:image).merge(user_id: current_user.id)
  end
end
