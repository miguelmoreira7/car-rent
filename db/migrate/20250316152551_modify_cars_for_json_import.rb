class ModifyCarsForJsonImport < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :city_mpg, :integer
    add_column :cars, :combination_mpg, :integer
    add_column :cars, :cylinders, :integer
    add_column :cars, :displacement, :float
    add_column :cars, :drive, :string
    add_column :cars, :highway_mpg, :integer
    add_column :cars, :transmission, :string
    add_column :cars, :class, :string
    add_column :cars, :make, :string
  end
end
