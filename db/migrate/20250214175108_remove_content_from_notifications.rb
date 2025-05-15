class RemoveContentFromNotifications < ActiveRecord::Migration[8.0]
  def change
    remove_column :notifications, :content, :string
  end
  
end
