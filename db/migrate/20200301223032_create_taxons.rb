class CreateTaxons < ActiveRecord::Migration[5.2]
  def change
    create_table :taxons do |t|

      t.timestamps
    end
  end
end
