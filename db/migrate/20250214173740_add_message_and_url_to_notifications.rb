class AddMessageAndUrlToNotifications < ActiveRecord::Migration[8.0]
  def change
    add_column :notifications, :message, :string
    add_column :notifications, :url, :string
  end
end
