# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  enum status: {
    未整理: 0,
    出品候補: 1,
    出品中: 2,
    売却済み: 3,
    保留: 4,
    手放さない: 5
  }

  enum category: {
    cd: 0,
    clothes: 1,
    electronics: 2,
    book: 3,
    game: 4,
    gadget: 5
  }

  validates :name, presence: true
  validates :status, presence: true
  validates :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :images, length: { maximum: 10 }

  def available_statuses
    case status
    when "出品候補"
      ["出品候補", "出品中"]

    when "出品中"
      ["出品中", "売却済み"]

    when "売却済み"
      ["売却済み"]

    else
      ["出品候補"]
    end
  end

  def self.category_options
    {
      cd: "CD",
      clothes: "服",
      electronics: "家電",
      book: "本",
      game: "ゲーム",
      gadget: "ガジェット"
    }
  end
end