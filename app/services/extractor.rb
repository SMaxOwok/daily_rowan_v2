require "zip"

class Extractor < ActiveInteraction::Base
  file :upload

  UPLOAD_DIR = Rails.root.join("tmp", "image_uploads")

  def execute
    zip? ? extract_and_queue_images : queue_image
  end

  private

  def zip?
    File.extname(upload) == ".zip"
  end

  def extract_and_queue_images
    extract
    queue_images
    teardown
  end

  def queue_image
    photo = Photo.new
    photo.image.attach(io: File.open(upload), filename: upload)
    photo.save
  end

  def extract
    ::Zip::File.open(upload) do |zip_file|
      zip_file.each do |f|
        fpath = File.join("tmp/image_uploads", f.name)
        FileUtils.mkdir_p(File.dirname(fpath))
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end

  def queue_images
    images = Dir.glob(Rails.root.join(UPLOAD_DIR, "*"))
    return unless images.present?
    images.each do |i|
      photo = Photo.new
      photo.image.attach(io: File.open(i), filename: i)
      photo.save
    end
  end
  
  def teardown
    FileUtils.rm_rf UPLOAD_DIR
  end

end