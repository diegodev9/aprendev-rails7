class Product < ApplicationRecord
  include PgSearch::Model
  include Favoritable

  has_one_attached :photo
  belongs_to :category
  belongs_to :user, default: -> { Current.user }

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B'
  }

  ORDER_BY = {
    newest: 'created_at DESC',
    expensive: 'price DESC',
    cheapest: 'price ASC'
  }.freeze

  def to_param
    "#{id}-#{title.downcase.to_s[0..100]}".parameterize
  end

  def owner?
    user_id == Current.user&.id
  end

  def broadcast
    broadcast_replace_to self, partial: 'products/product_details', locals: { product: self }
  end
end
