source 'https://rubygems.org'

gem 'rails', '3.2.7'
gem "audited-activerecord", "~> 3.0"
gem 'paper_trail', '~> 2'
gem 'yard'
gem 'calendar_date_select', :git =>  'http://github.com/paneq/calendar_date_select.git', :branch => 'rails3test'
gem "breadcrumbs_on_rails"
gem 'rails3-jquery-autocomplete'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem "twitter-bootstrap-rails"


group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
 gem 'bcrypt-ruby'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :test, :development do
  gem 'cucumber-rails', :require=>false
  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions  
  gem 'database_cleaner' # to clear Cucumber's test database between runs
  gem 'capybara'         # lets Cucumber pretend to be a web browser
  gem 'launchy'          # a useful debugging aid for user stories
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'simplecov'
#  gem "audited-activerecord", "~> 3.0"  
end
