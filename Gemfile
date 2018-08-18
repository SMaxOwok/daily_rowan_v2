source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "active_interaction", "~> 3.6"
gem "aws-sdk"
gem "autoprefixer-rails"
gem "dotenv-rails", "~> 2.0"
gem "foreman"
gem "jquery-rails"
gem "mini_magick"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.7"
gem "rails", "~> 5.2"
gem "rubyzip"
gem "sass-rails", "~> 5.0"
gem "sidekiq"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "pry"
  gem "rspec-rails", "~> 3.7"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "database_cleaner"
  gem "factory_bot_rails"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
