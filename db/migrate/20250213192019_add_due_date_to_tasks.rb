class AddDueDateToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :due_date, :date
  end
end
