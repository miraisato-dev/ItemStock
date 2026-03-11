# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :authenticate_user!  # ログイン必須

  before_action :set_item, only: %i[ show edit update destroy ]

  def dashboard
    @items = current_user.items

    @total = @items.count
    @selling = @items.出品中.count
    @sold = @items.売却済み.count
    @candidate = @items.出品候補.count
    @revenue = @items.売却済み.sum(:price)
  end

  def index
    # 今ログインしているユーザーのアイテムだけ取得
    @items = current_user.items

    if params[:status].present?
      @items = @items.where(status: params[:status])
    end

    if params[:keyword].present?
      @items = @items.where("name LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @items = @items.where(category: params[:category])
    end
  end

  def show
  end

  def new
    @item = current_user.items.build
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: "Item was successfully destroyed."
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :status, :memo, images: [])
  end
end
