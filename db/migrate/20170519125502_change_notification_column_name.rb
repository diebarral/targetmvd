class ChangeNotificationColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :notifications, :user_id, :recipient
  end
end
