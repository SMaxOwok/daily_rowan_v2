require "fileutils"

class CreatePhotoByUploadJob < ActiveJob::Base

  def perform(upload)
    return unless upload.present?

    photo = Photo.create do |p|
      p.image.attach(io: File.open(upload.file_on_disk), filename: upload.filename)
    end

    if photo.persisted?
      upload.destroy
    end
  end

end