# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  enum status: { 未出品: 0, 出品中: 1, 売却済み: 2 }
end
