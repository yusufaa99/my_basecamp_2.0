class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, foreign_key: :assigned_to, optional: true
  belongs_to :assigned_user, class_name: "User", foreign_key: "assigned_to", optional: true


  validates :description, presence: true
  validates :project, presence: true 
  validates :project_id, presence: true 
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in-progress completed], message: "must be 'pending', 'in-progress', or 'completed'" }

  scope :pending, -> { where(status: "pending") }
end