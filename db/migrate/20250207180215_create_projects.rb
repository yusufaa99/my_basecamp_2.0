class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string   :title,        null: false
      t.text     :description
      t.datetime :deadline
      t.integer  :creator_id,   null: false

      t.timestamps
    end

    add_index :projects, :creator_id
  end
end
