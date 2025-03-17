class Car < ApplicationRecord
    belongs_to :manufacturer
    has_many :cart_items
    has_many :carts, through: :cart_items
end