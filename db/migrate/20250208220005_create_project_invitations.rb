class CreateProjectInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :project_invitations do |t|
      t.references :project, null: false, foreign_key: true
      t.string :email, null: false
      t.references :inviter, null: false, foreign_key: { to_table: :users }
      t.string :token, null: false
      t.string :status, null: false, default: "pending"  # e.g. pending, accepted, declined

      t.timestamps
    end

    add_index :project_invitations, :token, unique: true
  end
end
