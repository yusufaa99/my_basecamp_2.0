class User < ApplicationRecord
  # Include default devise modules. Available modules are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validation for additional profile fields
  validates :email, presence: true, uniqueness: true

  # Optional: If you add extra fields (e.g., name, bio)
  # validates :name, presence: true

  # Helper method to check if the user is admin
  def admin?
    self.admin == true
  end
end
