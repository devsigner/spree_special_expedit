# -*- encoding : utf-8 -*-
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # Sort through your spec_helper file. Place as much environment loading 
  # code that you don't normally modify during development in the 
  # Spork.prefork block.
  # Place the rest under Spork.each_run block
  # Any code that is left outside of the blocks will be ran during preforking
  # and during each_run!
  
  # Configure Rails Environment
  ENV["RAILS_ENV"] = "test"

  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'rspec/rails'
  require 'pp'
  require 'spree_core/testing_support/factories'

  module ControllerMacros
    def login_admin
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:admin_user]
        admin = Factory.create(:admin_user)
        sign_in admin
      end
    end

    def login_user
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = Factory.create(:user)
        #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
        sign_in user
      end
    end
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    #config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
    config.include Devise::TestHelpers, :type => :controller
    config.extend ControllerMacros, :type => :controller
    config.render_views = true
    config.before(:each) do 
      AppConfiguration.find_or_create_by_name("Default configuration")
    end
  end

  def create_product(options = {}) 
    p = Factory.create(:product)
    if options[:with_sample]
      p.has_sample = 'true'
      p.save!
    end
    p
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  require 'rspec/rails'
  load "#{Rails.root}/../../app/models/calculator/special.rb"
#  Dir["#{Rails.root}/app/models//*.rb"].each do |model|
#    logger.info(model)
#    load model
#  end
end





