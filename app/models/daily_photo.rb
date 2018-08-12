class DailyPhoto < ApplicationRecord

  # Relationships
  belongs_to :photo, counter_cache: true

  # Scopes
  scope :last_five, -> { order(created_at: :desc).offset(1).limit(5).reverse_order }


  class << self
    def get_current
      where(date: Date.current).first_or_create do |daily_photo|
        daily_photo.photo = Photo.least_shown.sample
      end
    end
  end

end