class ChangeCardColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :cards, :customer_id, :string
    change_column :cards, :card_id, :string
  end
end
