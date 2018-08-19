class DailyPhoto < ApplicationRecord

  # Relationships
  belongs_to :photo, counter_cache: true

  # Scopes
  scope :last_five, -> { order(created_at: :desc).offset(1).limit(5) }

  delegate :image, to: :photo
  delegate :orientation, to: :photo

  class << self
    def get_current
      photos = Photo.least_shown

      photo = if photos.not_recent.any?
                photos.not_recent.sample
              else
                photos.sample
              end

      return nil unless photo.present?

      where(date: Date.current).first_or_create do |daily_photo|
        daily_photo.photo = photo
      end
    end
  end

end