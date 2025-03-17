class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :car
  
    validates :quantity, numericality: { greater_than: 0 }
  end
  