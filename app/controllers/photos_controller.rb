class PhotosController < ApplicationController

  def index
    @daily_photo = DailyPhoto.includes(:photo).get_current
    @last_five = DailyPhoto.includes(:photo).last_five
  end
end