class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception

  validates :name, presence: true

  scope :category_select, -> { Category.all.order(name: :asc).map{|cat| [cat.name, cat.id]} }
end
