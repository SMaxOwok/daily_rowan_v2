namespace :development do

  desc "Loads development data"
  task load: :environment do
    Development::DataLoader.run
  end

end
