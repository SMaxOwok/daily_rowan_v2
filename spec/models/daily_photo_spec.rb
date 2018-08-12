require "rails_helper"

RSpec.describe DailyPhoto, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:daily_photo)).to be_valid
  end

  context "when getting today's photo" do
    it "creates a new record if none exists" do
      FactoryBot.create(:daily_photo, date: Date.current - 2.days)
      expect { DailyPhoto.get_current }.to change { DailyPhoto.count }.by 1
    end

    it "returns the current day's photo" do
      daily_photo = FactoryBot.create(:daily_photo)
      expect(DailyPhoto.get_current).to eq daily_photo
    end
  end
end
