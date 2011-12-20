source 'http://rubygems.org'

gem 'sqlite3'

group :test do
  gem 'rspec-rails', '= 2.6.1'
  #gem 'spree'
  gem 'spree_core'
  gem 'spree_auth'
  #gem 'spree_api'
  #gem 'spree_dash'  
  #gem 'spree_promo'
  gem 'spork'
  gem 'guard-spork', :git => 'git://github.com/guard/guard-spork.git'
  gem 'webrat'
  gem 'ZenTest'
  gem 'faker'
  gem 'factory_girl'
end

group :cucumber do
  gem 'cucumber-rails', '1.0.0'
  gem 'database_cleaner', '= 0.6.7'
  gem 'nokogiri'
  gem 'capybara', '1.0.1'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

gemspec
