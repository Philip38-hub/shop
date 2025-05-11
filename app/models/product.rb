class Product < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  # If using Active Storage instead of CarrierWave
  has_one_attached :image

  validates :title, :brand, :price, :model, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed. " }
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum allowed. " }
  validates :price, length: { maximum: 10 }
  validates :image, presence: true

  # Constants for brands, finishes, and conditions
  BRAND = %w{ Ferrari Opel Lenovo Fossil }
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }
end