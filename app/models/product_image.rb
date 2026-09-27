class ProductImage < ApplicationRecord
  belongs_to :product

  validates :image_url, presence: true
  validates :public_id, presence: true
end
