FactoryBot.define do
  factory :photo do
    after(:build) do |photo|
      photo.image.attach(io: File.open(Rails.root.join("spec", "data", "assets", "images", "portrait.jpg")),
                           filename: "portrait.jpg")
    end
  end
end