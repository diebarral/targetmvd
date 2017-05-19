class AddUserToMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :user_a_id, :integer
    add_column :matches, :user_b_id, :integer

    add_foreign_key :matches, :users, column: :user_a_id
    add_foreign_key :matches, :users, column: :user_b_id

  end
end
