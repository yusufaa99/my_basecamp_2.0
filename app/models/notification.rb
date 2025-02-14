class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where(read: false) }

  validates :content, presence: true
end