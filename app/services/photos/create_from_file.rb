require "zip"

module Photos
  class CreateFromFile < ActiveInteraction::Base
    file :upload

    UPLOAD_DIR = Rails.root.join("tmp", "image_uploads")

    def execute
      zip? ? extract_and_queue_images : queue_image
    end

    private

    def extract_and_queue_images
      extract
      queue_images
    end

    def queue_image
      PhotoCreateJob.perform_later upload
    end

    def zip?
      File.extname(upload) == ".zip"
    end

    def extract
      ::Zip::File.open(upload) do |zip_file|
        zip_file.each do |f|
          fpath = File.join(UPLOAD_DIR, f.name)
          FileUtils.mkdir_p(File.dirname(fpath))
          zip_file.extract(f, fpath) unless File.exist?(fpath)
        end
      end
    end

    def queue_images
      images = Dir.glob(Rails.root.join(UPLOAD_DIR, "*"))
      return unless images.present?

      QueuePhotoCreateJobs.perform_later images
    end

  end
end