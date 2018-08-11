require "rails_helper"

RSpec.describe DailyPhoto, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:daily_photo)).to be_valid
  end
end
