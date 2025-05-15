class CreateProjectThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :project_threads do |t|
      t.string :title
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
