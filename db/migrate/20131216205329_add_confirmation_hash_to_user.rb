class AddConfirmationHashToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_hash, :text
    add_column :users, :activate, :boolean
  end
end
