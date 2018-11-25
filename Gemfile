# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'cancancan'
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap-sass', '~> 3.3.5'
gem 'factory_bot_rails'
gem 'faker'
gem 'jbuilder', '~> 2.5'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'uglifier', '>= 1.3.0'
gem 'devise'
gem 'jquery-rails'
gem 'font-awesome-sass'

group :development, :test do
  gem 'annotate'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'pry'
  gem 'rspec-rails', '~> 3.7.0'
  gem 'shoulda'
  gem 'solargraph'
end

group :development do
  gem 'rubocop'
  gem 'spring'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
