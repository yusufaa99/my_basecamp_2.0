class CreateSolidQueueJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :job_type
      t.text :arguments
      t.string :status, default: "pending"
      t.timestamps
    end
  end
end
