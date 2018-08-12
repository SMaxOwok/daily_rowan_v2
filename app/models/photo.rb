class Photo < ApplicationRecord
  # Constants
  ORIENTATION_PORTRAIT = "portrait".freeze
  ORIENTATION_LANDSCAPE = "landscape".freeze
  VALID_ORIENTATIONS = [ORIENTATION_LANDSCAPE, ORIENTATION_PORTRAIT].freeze

  # Relationships
  has_one_attached :image
  has_many :daily_photos, dependent: :destroy

  # Scopes
  scope :least_shown, -> do
    count = order(daily_photos_count: :asc).pluck(:daily_photos_count).first
    where(daily_photos_count: count)
  end

  # Validations
  validates :dimensions, presence: true
  validates :orientation, inclusion: { in: VALID_ORIENTATIONS }

  # Callbacks
  before_validation :set_dimensions!, :set_orientation!

  def width
    dimensions[0]
  end

  def height
    dimensions[1]
  end

  def landscape?
    orientation == ORIENTATION_LANDSCAPE
  end

  def portrait?
    orientation == ORIENTATION_PORTRAIT
  end

  class << self
    def available_photos
      return new_photos if new_photos.any?
      return upcoming_photos if upcoming_photos.any?
      all
    end
  end

  private

  def set_dimensions!
    data = ActiveStorage::Analyzer::ImageAnalyzer.new(image).metadata
    self.dimensions = data.values
  end

  def set_orientation!
    self.orientation = width > height ? ORIENTATION_LANDSCAPE : ORIENTATION_PORTRAIT
  end
end