class AddUserToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :user_id, :integer
    add_foreign_key :messages, :users, column: :user_id
  end
end
