# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in rails-vault-jwt.gemspec
gemspec

group :development, :test do
  gem 'rubocop', '~> 1.7'
  gem 'rubocop-rake', '~> 0.5'
  gem 'rubocop-rspec', '~> 2.1'
end

group :test do
  gem 'simplecov', '~> 0.19', require: false
end
