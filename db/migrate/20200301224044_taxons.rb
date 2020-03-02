class Taxons < ActiveRecord::Migration[5.2]
  def change
    add_column :taxons, :name, :string
  end
end
