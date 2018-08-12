class PhotosController < ApplicationController

  def index
    @daily_photo = DailyPhoto.get_current
    @last_five = DailyPhoto.last_five
  end
end