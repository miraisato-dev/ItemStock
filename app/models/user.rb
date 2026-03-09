# app/models/user.rb
class User < ApplicationRecord
  # Devise モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # User と Item を 1対多で紐付け
  has_many :items, dependent: :destroy
end
