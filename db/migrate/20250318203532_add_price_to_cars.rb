class AddPriceToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :price, :decimal
  end
end
