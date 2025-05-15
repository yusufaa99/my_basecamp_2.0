class AddDescriptionToProjectThreads < ActiveRecord::Migration[8.0]
  def change
    add_column :project_threads, :description, :text
  end
end
