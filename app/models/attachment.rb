class Attachment < ApplicationRecord
  belongs_to :project
  belongs_to :user  # the user who uploaded the attachment

  # validates :file_url, presence: true
  validates :file_format, presence: true, inclusion: { in: %w(png jpg jpeg pdf txt) }

  has_one_attached :file  # Active Storage for file uploads

  validate :file_or_url_present

  private

  def file_or_url_present
    if file.blank? && file_url.blank?
      errors.add(:base, "Either upload a file or provide a file URL")
    end
  end
end
