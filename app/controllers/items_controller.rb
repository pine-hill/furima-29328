class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:show, :edit ,:update ,:destroy]
  before_action :new_ordered_items, only: [:index, :show]
  #before_action :correct_user, only: [:show]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to action: :index
    else
      render :destroy
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :price, :description, :category_id, :condition_id, 
      :handling_time_id, :postage_id, :prefecture_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def new_ordered_items
    @ordered_items = OrderedItem.all
  end

  #def correct_user
    #@micropost = current_user.microposts.find_by(id: params[:id])
      #unless @micropost
        #redirect_to root_path
      #end
  #end

  #def current_user
    #User.find_by(id: session[:user_id])
  #end
end