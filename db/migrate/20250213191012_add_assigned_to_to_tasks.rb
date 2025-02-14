class AddAssignedToToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :assigned_to, :integer
  end
end
