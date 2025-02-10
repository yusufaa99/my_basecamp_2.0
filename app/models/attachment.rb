class Attachment < ApplicationRecord
  belongs_to :project
  belongs_to :user  # the user who uploaded the attachment

  validates :file_url, presence: true
  validates :file_format, presence: true, inclusion: { in: %w(png jpg jpeg pdf txt) }
end
