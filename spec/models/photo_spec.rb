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

  it "has a scope that returns photos with the lowest count" do
    photo_a = FactoryBot.create(:photo)
    photo_b = FactoryBot.create(:photo)
    photo_c = FactoryBot.create(:photo)

    3.times { FactoryBot.create(:daily_photo, photo: photo_a) }
    3.times { FactoryBot.create(:daily_photo, photo: photo_b) }
    2.times { FactoryBot.create(:daily_photo, photo: photo_c) }

    expect(described_class.least_shown).to eq [photo_c]
  end
end
