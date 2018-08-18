require "fileutils"

class CreatePhotoByUploadJob < ActiveJob::Base

  def perform(upload)
    return unless upload.present?

    photo = Photo.create do |p|
      p.image.attach(io: StringIO.new(upload.file.blob.download),
                     filename: upload.filename)
    end

    if photo.persisted?
      upload.file.purge_later
    end
  end

end