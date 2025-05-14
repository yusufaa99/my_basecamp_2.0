class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :role, presence: true, inclusion: { in: %w(admin member observer) }

  # Helper methods for checking roles
  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end

  def observer?
    role == "observer"
  end
end
