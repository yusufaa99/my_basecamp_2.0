class Message < ApplicationRecord
  belongs_to :project_thread
  belongs_to :user  # The author of the message

  validates :content, presence: true
end
