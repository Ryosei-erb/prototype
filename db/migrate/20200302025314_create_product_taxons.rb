class CreateProductTaxons < ActiveRecord::Migration[5.2]
  def change
    create_table :product_taxons do |t|
      t.integer :product_id
      t.integer :taxon_id

      t.timestamps
    end
  end
end
