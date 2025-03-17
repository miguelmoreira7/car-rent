class Reservation < ApplicationRecord
  belongs_to :user
  has_many :reservation_items, dependent: :destroy
  has_many :cars, through: :reservation_items
end
