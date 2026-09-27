class Product < ApplicationRecord
  belongs_to :user

  has_many :product_images, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
