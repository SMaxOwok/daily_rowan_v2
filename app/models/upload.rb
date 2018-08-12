class Upload < ApplicationRecord
  # Constants
  VALID_EXTS = %w(.zip .jpg .jpeg .png)

  # Relationships
  has_one_attached :file

  validate :valid_file!

  def filename
    file.blob.filename.to_s
  end

  def file_on_disk
    ActiveStorage::Blob.service.send(:path_for, file.key)
  end

  private

  def valid_file!
    errors.add(:file, "is required.") unless file_present?
    errors.add(:file, "extension is not valid.") unless valid_ext?

    return true if errors.blank?

    file.purge
    true
  end

  def file_present?
    file.attachment.present?
  end

  def valid_ext?
    return false unless file_present?
    VALID_EXTS.include? File.extname(filename)
  end
end