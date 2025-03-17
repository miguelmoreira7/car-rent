class CreateCars < ActiveRecord::Migration[8.0]
  def change
    create_table :cars do |t|
      t.string :model
      t.integer :year
      t.string :fuel_type
      t.integer :manufacturer_id
      t.integer :quantity

      t.timestamps
    end
  end
end
