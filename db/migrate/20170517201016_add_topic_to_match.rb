class AddTopicToMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :topic_id, :integer
    add_foreign_key :matches, :topics, column: :topic_id
  end
end
