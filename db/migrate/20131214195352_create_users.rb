class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :app_id
      t.text :email
      t.text :password_hash
      t.text :password_salt
      t.datetime :last_login

      t.timestamps
    end
  end
end
