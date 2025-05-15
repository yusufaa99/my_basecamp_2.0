class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where(read: false) }

  default_scope { order(created_at: :desc) }
end
