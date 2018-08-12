require "rails_helper"

RSpec.describe Photo, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:photo)).to be_valid
  end

  it "assigns the image dimensions" do
    photo = FactoryBot.create(:photo)
    expect(photo.dimensions).to_not eq []
  end

  it "assigns the correct orientation" do
    photo = FactoryBot.create(:photo)
    expect(photo.orientation).to eq Photo::ORIENTATION_PORTRAIT
  end
end
