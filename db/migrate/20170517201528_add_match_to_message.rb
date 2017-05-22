class AddMatchToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :match_id, :integer
    add_foreign_key :messages, :matches, column: :match_id
  end
end
