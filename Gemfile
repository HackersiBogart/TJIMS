source "https://rubygems.org"

ruby "3.3.4"

gem "rails", "~> 7.1.4"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "devise", "~> 4.9"
gem "font-awesome-sass", "~> 6.5.1"
gem "pagy", "~> 9.0"
gem "foreman", github: "ddollar/foreman"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"
gem "prawn"

# Use sqlite3 for development and production
group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'sqlite3', '~> 1.4'
end

group :production do
  gem 'pg', '~> 1.5.0'
  gem 'rails_12factor'
  gem 'sqlite3', '~> 1.4'  # Add this line if you are using SQLite in production
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem 'groupdate'
