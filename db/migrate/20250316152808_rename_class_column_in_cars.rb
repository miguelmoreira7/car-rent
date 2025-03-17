class RenameClassColumnInCars < ActiveRecord::Migration[8.0]
  def change
    rename_column :cars, :class, :car_class
  end
end
