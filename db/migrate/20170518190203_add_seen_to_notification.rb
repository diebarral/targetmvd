class AddSeenToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :seen, :boolean, default: true
  end
end
