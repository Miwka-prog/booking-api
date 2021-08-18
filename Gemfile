source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # rubocop
  gem 'rubocop', '~> 1.14'
  gem 'rubocop-performance', '~> 1.11', '>= 1.11.3'
  gem 'rubocop-rails', '~> 2.10', '>= 2.10.1'
  gem 'rubocop-rspec', '~> 2.3'

  gem 'fasterer', '~> 0.9.0'
  gem 'overcommit', '~> 0.57.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
