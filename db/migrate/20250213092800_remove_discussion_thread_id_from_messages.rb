class RemoveDiscussionThreadIdFromMessages < ActiveRecord::Migration[8.0]
  def change
    remove_column :messages, :discussion_thread_id, :bigint
  end
end
