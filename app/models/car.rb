class Car < ApplicationRecord
    belongs_to :manufacturer
    has_many :cart_items
    has_many :carts, through: :cart_items
    has_many :reservation_items
    has_many :reservations, through: :reservation_items
    
end