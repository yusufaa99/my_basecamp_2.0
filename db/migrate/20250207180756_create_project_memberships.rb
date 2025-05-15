class CreateProjectMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :project_memberships do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user,    null: false, foreign_key: true
      t.string     :role,    null: false, default: "member"  # default role

      t.timestamps
    end

    # Optionally, add an index for quick look-up
    add_index :project_memberships, [:project_id, :user_id], unique: true
  end
end
