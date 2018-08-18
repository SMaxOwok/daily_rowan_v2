module Development
  class DataLoader < ActiveInteraction::Base

    def execute
      truncate_db
      load_photos
      load_daily_photos
    end

    private

    def truncate_db
      clear = %w(Photo Upload)
      clear.each do |model_name|
        puts "Truncating #{model_name} table"
        model_name.constantize.destroy_all
      end
    end

    def load_photos
      images.each do |image|
        Photo.create do |photo|
          photo.image.attach(io: File.open(image),
                             filename: File.basename(image))
        end

        puts "Created photo for #{File.basename(image)}"
      end
    end

    def load_daily_photos
      (Date.current - 6.days..Date.current).each do |date|
        DailyPhoto.create(photo: Photo.least_shown.sample, date: date)

        puts "Create DailyPhoto for #{date.strftime('%b %d, %Y')}"
      end
    end

    def images
      @images ||= Dir.glob(Rails.root.join("spec", "data", "assets", "images", "*"))
    end

  end
end