class AddRecipientToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :user_id, :integer
    add_foreign_key :notifications, :users, column: :user_id
  end
end
