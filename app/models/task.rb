class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, foreign_key: :assigned_to, optional: true
  belongs_to :assigned_user, class_name: "User", foreign_key: "assigned_to", optional: true

  before_save :set_user_id


  validates :description, presence: true
  validates :project, presence: true 
  validates :project_id, presence: true 
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in-progress completed], message: "must be 'pending', 'in-progress', or 'completed'" }

  scope :pending, -> { where(status: "pending") }

  private

  def set_user_id
    self.user_id = assigned_to if assigned_to.present?
  end
end