class ProjectThread < ApplicationRecord
  belongs_to :project
  belongs_to :user  # The creator of the thread

  has_many :messages, dependent: :destroy

  validates :title, presence: true
  validates :user, presence: true
end
