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
  # def index
  #   @items = current_user.items
  #   @items = @items.where(status: params[:status]) if params[:status].present?
  #   @items = @items.where("name LIKE ?", "%#{params[:keyword]}%") if params[:keyword].present?
  #   @items = @items.where(category: params[:category]) if params[:category].present?
  # end

  def index
    @items = current_user.items

    @items = @items.where(status: params[:status]) if params[:status].present?
    @items = @items.where("name LIKE ?", "%#{params[:keyword]}%") if params[:keyword].present?
    @items = @items.where(category: params[:category]) if params[:category].present?

    case params[:sort]
    when "new"
      @items = @items.order(created_at: :desc)
    when "old"
      @items = @items.order(created_at: :asc)
    when "price_high"
      @items = @items.order(price: :desc)
    when "price_low"
      @items = @items.order(price: :asc)
    else
      @items = @items.order(created_at: :desc)
    end
  end

  def show; end

  def new
    @item = current_user.items.new(status: "draft")
  end

  def edit; end

  def create
    @item = current_user.items.build(item_params)
    @item.user = current_user

    if @item.save
      redirect_to @item, notice: "アイテムは正常に作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @item = current_user.items.find(params[:id])

    # 削除処理
    if params[:remove_image_ids].present?
      params[:remove_image_ids].each do |id|
        @item.images.find(id).purge
      end
    end

    # 基本更新（画像以外）
    if @item.update(item_params.except(:images, :existing_image_ids))

      # 並び替え（既存画像）
      # if params[:item][:existing_image_ids].present?
      #   ordered_attachments = params[:item][:existing_image_ids].map do |id|
      #     ActiveStorage::Attachment.find(id)
      #   end
      if params[:item][:existing_image_ids].present?
        ordered_ids = params[:item][:existing_image_ids]

        ordered_attachments = ordered_ids.map do |id|
          ActiveStorage::Attachment.find(id)
        end

        # 一回リセット
        @item.images.detach
        # @item.images.attachments.each(&:purge)

        # 順番通りに付け直す
        ordered_attachments.each do |attachment|
          @item.images.attach(attachment.blob)
        end
      end

        # 並び順で再attach
      #   ordered_attachments.each do |attachment|
      #     @item.images.attach(attachment.blob)
      #   end
      # end

      # 新規画像は最後に追加
      if params[:item][:images].present?
        params[:item][:images].each do |img|
          # @item.images.attach(img)
          @item.item_images.create!(
            image: img,
            position: index
          )
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
      :name, 
      :category, 
      :price, 
      :status, 
      :description, 
      :memo, 
      :user_id,
      images: [],           # 新規追加画像
      existing_image_ids: [] # 既存画像を残すため
    )
  end
end
