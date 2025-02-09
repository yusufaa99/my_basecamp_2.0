class DiscussionThread < ApplicationRecord
  belongs_to :user  # The creator of the thread
  belongs_to :project, optional: true  # If threads are tied to a project
  has_many :messages, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
