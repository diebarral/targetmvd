class AddTopicToTarget < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :topic_id, :integer
  end
end
