source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails',                   '~> 5.2.1'
gem 'pg',                      '>= 0.18', '< 2.0'
gem 'puma',                    '~> 3.11'
gem 'sass-rails',              '~> 5.0'
gem 'uglifier',                '>= 1.3.0'
gem 'coffee-rails',            '~> 4.2'
gem 'turbolinks',              '~> 5'
gem 'jbuilder',                '~> 2.5'
gem 'bootsnap',                '>= 1.1.0', require: false

# Take care of credentials.
gem 'figaro',                  '~> 1.1', '>= 1.1.1'

# Consume restful web services.
gem 'httparty',                '~> 0.16.2'

group :development, :test do
  gem 'pry-byebug',            '~> 3.6'
  gem 'rspec-rails',           '~> 3.8'
  gem 'rubocop-rails_config',  '~> 0.2.5'

  # Limit connections to API.
  gem 'vcr',                   '~> 4.0'
  gem 'webmock',               '~> 3.4', '>= 3.4.2'
end

group :development do
  gem 'better_errors',         '~> 2.5'
  gem 'binding_of_caller',     '~> 0.8.0'
  gem 'guard',                 '~> 2.14', '>= 2.14.2'
  gem 'guard-rspec',           require: false
  gem 'guard-rubycritic',      '~> 2.9', '>= 2.9.3'

  gem 'web-console',           '>= 3.3.0'
  gem 'listen',                '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara',              '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'

  # Test XML generation.
  gem 'equivalent-xml',        '~> 0.6.0'

  # Coverage.
  gem 'simplecov',             require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
