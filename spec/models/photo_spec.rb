require "rails_helper"

RSpec.describe Photo, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:photo)).to be_valid
  end
end
