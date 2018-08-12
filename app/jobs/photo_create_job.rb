require "fileutils"

class PhotoCreateJob < ActiveJob::Base

  def perform(path)
    return unless path.present?

    photo = Photo.create do |p|
      p.image.attach(io: File.open(path), filename: File.basename(path))
    end

    if photo.persisted?
      FileUtils.rm path
    end
  end

end