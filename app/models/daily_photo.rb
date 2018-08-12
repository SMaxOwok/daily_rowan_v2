class DailyPhoto < ApplicationRecord

  # Relationships
  belongs_to :photo, counter_cache: true

  # Scopes
  scope :last_five, -> { order(created_at: :desc).offset(1).limit(5).reverse_order }

end