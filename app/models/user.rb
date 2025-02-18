class User < ApplicationRecord
  # Devise modules...
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true

  # For profile fields (if added)
  # validates :name, presence: true

  # Check if the user is a site-wide admin (from Milestone 1)
  def admin?
    self.admin == true
  end
  
  # Associations for projects membership
  has_many :project_memberships, dependent: :destroy
  has_many :projects, through: :project_memberships

  has_many :tasks, through: :projects, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :activities, dependent: :destroy
end
