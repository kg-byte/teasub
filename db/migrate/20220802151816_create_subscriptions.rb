class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.integer :title
      t.integer :price
      t.integer :status
      t.integer :frequency
      
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
