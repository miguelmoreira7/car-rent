class CreateReservationItems < ActiveRecord::Migration[8.0]
  def change
    create_table :reservation_items do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
