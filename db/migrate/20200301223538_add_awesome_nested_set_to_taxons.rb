class AddAwesomeNestedSetToTaxons < ActiveRecord::Migration[5.2]
  def change
    add_column :taxons, :parent_id, :integer
    add_column :taxons, :lft, :integer
    add_column :taxons, :rgt, :integer

    add_index :taxons, :parent_id
    add_index :taxons, :lft
    add_index :taxons, :rgt
  end
end
