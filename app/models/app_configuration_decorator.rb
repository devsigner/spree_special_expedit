# -*- encoding : utf-8 -*-
AppConfiguration.class_eval do
  
  preference :sample_default_weight, :float, :default => 1.0
  
  def preferred_sample_default_weight
    Spree::Config['sample_default_weight']
  end
  
end
