# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[ show edit update destroy ]
  # before_action :set_item, only: %i[ show edit update destroy ]

  # ===== ダッシュボード =====
  def dashboard
    @total_items     = current_user.items.count
    @selling_items   = current_user.items.listed.count
    @sold_items      = current_user.items.sold.count
    @candidate_items = current_user.items.draft.count
    @total_sales     = current_user.items.sold.sum(:price)
  end

  # ===== 一覧 =====
  def index
    @items = current_user.items
    @items = @items.where(status: params[:status]) if params[:status].present?
    @items = @items.where("name LIKE ?", "%#{params[:keyword]}%") if params[:keyword].present?
    @items = @items.where(category: params[:category]) if params[:category].present?
  end

  def show; end

  def new
    @item = current_user.items.new(status: "draft")
  end

  def edit; end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to @item, notice: "アイテムは正常に作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @item = current_user.items.find(params[:id])

    # 削除指定の既存画像を消す
    if params[:remove_image_ids].present?
      params[:remove_image_ids].each do |id|
        @item.images.find(id).purge
      end
    end

    # 既存画像を残したまま、新規追加画像を attach
    if @item.update(item_params.except(:images))
      if params[:item][:images].present?
        params[:item][:images].each do |img|
          @item.images.attach(img)
        end
      end

      redirect_to @item, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, status: :see_other
  end

  # ===== ステータス別一覧 =====
  def before_listing
    @items = current_user.items.draft
    render :index
  end

  def listed
    @items = current_user.items.listed
    render :index
  end

  def sold
    @items = current_user.items.sold
    render :index
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, :category, :price, :status, :description, :memo, :user_id,
      images: [],           # 新規追加画像
      # existing_image_ids: [] # 既存画像を残すため
    )
  end
end