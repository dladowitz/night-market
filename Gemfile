source 'https://rubygems.org'
ruby '2.1.2'
gem 'rails', '4.1.6'

# gem "bootstrap-sass", "~> 3.2.0"
gem 'coffee-rails', '~> 4.0.0'
# gem "font-awesome-rails"
gem 'haml-rails'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'sass-rails', '~> 4.0.3'

# gem 'validates_timeliness', '~> 3.0' #TODO Move back to official version on Rails 4.2. Currently throwing deprecation warnings in rspec.
gem 'validates_timeliness', github: 'razum2um/validates_timeliness', ref: 'b195081f6aeead619430ad38b0f0dfe4d4981252'

gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'annotate'
  gem 'awesome_print'
  gem 'better_errors'
  gem 'spring'
end

group :development, :test do
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'faker'
  # gem 'fixture_builder'
  # gem 'jazz_hands'
  gem 'pry-byebug'
  gem 'quiet_assets'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'sqlite3'
end

group :test do
  gem 'capybara', require: false
  gem 'cucumber-rails', require: false
  gem 'launchy'
  gem 'shoulda-matchers'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

# group :production do
  # gem 'pg'
  # gem 'rails_12factor'
# end
