class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    if current_user.id == @item.user.id || @item.ordered_item != nil
      redirect_to root_path
    end
    @ordered_item_address = OrderedItemAddress.new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
    @ordered_item_address = OrderedItemAddress.new(ordered_item_address_params)
    if @ordered_item_address.valid?
      pay_item
      @ordered_item_address.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private
  def ordered_item_address_params
    params.permit(:post_code ,:prefecture_id ,:city ,:block ,:building_name ,
    :phone_number,:item_id,:token).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: ordered_item_address_params[:token],
      currency:'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end