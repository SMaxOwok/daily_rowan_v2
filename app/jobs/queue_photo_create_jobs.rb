class QueuePhotoCreateJobs < ActiveJob::Base

  def perform(image_paths)
    return unless image_paths.present?

    image_paths.each do |path|
      CreatePhotoByPathJob.perform_later path
    end
  end

end