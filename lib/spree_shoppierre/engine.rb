# -*- encoding : utf-8 -*-
module SpreeShoppierre
  class Engine < Rails::Engine
    engine_name 'spree_shoppierre'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end      
      Calculator::Special.register
      begin
      Spree::Config.set(:address_requires_state => false)
      rescue         
      end
    end
    
    config.to_prepare &method(:activate).to_proc
    config.after_initialize do |app|
      app.config.spree.calculators.shipping_methods += [
        Calculator::Special
      ]
    end
    
  end
end
