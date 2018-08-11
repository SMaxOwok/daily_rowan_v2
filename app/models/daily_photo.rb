class DailyPhoto < ApplicationRecord

  belongs_to :photo, counter_cache: true

end