class DailyPhoto < ApplicationRecord

  # Relationships
  belongs_to :photo, counter_cache: true

  # Scopes
  scope :last_five, -> { order(created_at: :desc).offset(1).limit(5).reverse_order }

  class << self
    def get_current
      photo = Photo.least_shown.sample

      return nil unless photo.present?

      where(date: Date.current).first_or_create do |daily_photo|
        daily_photo.photo = photo
      end
    end
  end

end