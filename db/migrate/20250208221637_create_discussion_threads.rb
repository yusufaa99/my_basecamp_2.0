class CreateDiscussionThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :discussion_threads do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
