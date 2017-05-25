class AddReadToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :read, :boolean
    rename_column :messages, :user_id, :destinatary
  end
end
