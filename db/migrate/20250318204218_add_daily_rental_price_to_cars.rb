class AddDailyRentalPriceToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :daily_rental_price, :decimal
  end
end
