class AddTotalPriceToReservations < ActiveRecord::Migration[8.0]
  def change
    add_column :reservations, :total_price, :decimal
  end
end
