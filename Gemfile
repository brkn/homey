# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  gem "brakeman", require: false
end

group :development do
  gem "rubocop", "~> 1.75", require: false
  gem "rubocop-performance", "~> 1.25", require: false
  gem "rubocop-rails", "~> 2.31", require: false
  gem "rubocop-rspec", "~> 3.5", require: false
  gem "rubocop-rspec_rails", "~> 2.31", require: false
end

group :test do
  gem "rspec-rails", "~> 7.1"
end
