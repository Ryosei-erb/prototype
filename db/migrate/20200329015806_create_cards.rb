class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.integer :customer_id
      t.integer :card_id

      t.timestamps
    end
  end
end
