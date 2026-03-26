# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  enum status: [:draft, :listed, :sold, :keep]
  enum category: [:cd, :clothes, :electronics, :book, :game, :gadget]

  validates :name, presence: true
  validates :status, presence: true
  validates :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :images, length: { maximum: 10 }

  def available_statuses
    case status.to_sym
    when :draft
      %i[draft listed]
    when :listed
      %i[listed sold]
    when :sold
      %i[sold]
    else
      %i[draft]
    end
  end

  def enum_i18n(name)
    value = public_send(name)
    return nil if value.blank?

    I18n.t("enums.item.#{name}.#{value}", default: value)
  end

  def category_i18n
    enum_i18n(:category)
  end

  def status_i18n
    enum_i18n(:status)
  end

  def self.enum_select_options(name)
    public_send(name.to_s.pluralize).keys.map do |k|
      [I18n.t("enums.item.#{name}.#{k}"), k]
    end
  end
end
