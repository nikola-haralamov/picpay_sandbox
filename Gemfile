# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :development, :test do
  gem "roda", "~> 3.72.0"
  gem "dotenv", "~> 2.8.1"
  gem "pry-byebug", "~> 3.10.1"
end

group :development do
  gem "yard", "~> 0.9.34"
end

group :test do
  gem "rspec", "~> 3.12.0"
  gem "factory_bot", "~> 6.3.0"
  #gem "webmock", "~> 3.19.1"
end
