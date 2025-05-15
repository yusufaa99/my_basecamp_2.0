class AddProjectThreadIdToMessages < ActiveRecord::Migration[8.0]
  def change
    add_reference :messages, :project_thread, null: false, foreign_key: true
  end
end
