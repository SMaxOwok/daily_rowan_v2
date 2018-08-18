require "zip"

module Photos
  class Creator < ActiveInteraction::Base
    object :upload

    UPLOAD_DIR = Rails.root.join("tmp", "image_uploads")

    def execute
      zip? ? extract_and_queue_images : queue_image
    end

    private

    def zip?
      File.extname(upload.filename) == ".zip"
    end

    def file_stream
      StringIO.new upload.file.blob.download
    end

    def extract
      ::Zip::File.open_buffer(file_stream) do |zip_file|
        files = zip_file.select(&:file?)
        files.reject! { |f| f.name =~ /\.DS_Store|__MACOSX|(^|\/)\._/ }

        files.each do |f|
          fpath = File.join(UPLOAD_DIR, f.name)
          FileUtils.mkdir_p(File.dirname(fpath))

          zip_file.extract(f, fpath)
        end
      end
    end

    def extract_and_queue_images
      extract
      queue_images
      upload.file.purge_later
    end

    def queue_images
      images = Dir.glob(Rails.root.join(UPLOAD_DIR, "*")).select { |file| File.file? file }
      return unless images.present?

      QueuePhotoCreateJobs.perform_later images
    end

    def queue_image
      CreatePhotoByUploadJob.perform_later upload
    end

  end
end