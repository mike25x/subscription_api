class CreateSubscriptionTypes < ActiveRecord::Migration
  def change
    create_table :subscription_types do |t|
      t.integer :app_id
      t.text :name
      t.integer :duration

      t.timestamps
    end
  end
end
