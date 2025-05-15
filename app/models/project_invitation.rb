class ProjectInvitation < ApplicationRecord
  belongs_to :project
  belongs_to :inviter, class_name: 'User'

  before_create :generate_token

  validates :email, presence: true
  validates :token, uniqueness: true

  private

  def generate_token
    self.token = SecureRandom.hex(10)
  end
end
