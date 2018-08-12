class ProcessUploadJob < ActiveJob::Base

  def perform(upload)
    return unless upload.present?

    Photos::Creator.run upload: upload
  end

end