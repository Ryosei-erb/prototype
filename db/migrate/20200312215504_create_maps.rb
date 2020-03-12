class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :address
      t.decimal :latitude,  precision: 11, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.integer :product_id
      t.timestamps
    end
  end
end
