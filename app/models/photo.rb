class Photo < ApplicationRecord

  has_one_attached :image
  has_many :daily_photos, dependent: :destroy

end