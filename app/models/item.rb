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

  validates :name, presence: true
  validates :status, presence: true
end