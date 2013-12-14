class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscription_type_id
      t.integer :user_id
      t.datetime :start_date
      t.datetime :end_date
      t.text :receipt
      t.float :price

      t.timestamps
    end
  end
end
