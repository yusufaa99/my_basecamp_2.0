class Project < ApplicationRecord
  # Existing associations
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  
  # Add the following line to associate project invitations with a project:
  has_many :project_invitations, dependent: :destroy

  # Other associations and validations...
  has_many :project_memberships, dependent: :destroy
  has_many :members, through: :project_memberships, source: :user

  has_many :project_threads, dependent: :destroy  # Ensure association with threads

  has_many :attachments, dependent: :destroy  # <-- new association
  has_many :tasks, dependent: :destroy
  
  validates :creator, presence: true

  validates :title, presence: true
  validates :deadline, presence: true
end