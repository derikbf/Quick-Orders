class OrderProduct < ApplicationRecord
  validates :observation, length: { maximum: 150 }
  validates :quantity, numericality: { greater_than 0 }
  
  belongs_to :order
  belongs_to :product
end