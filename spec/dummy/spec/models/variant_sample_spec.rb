# -*- encoding : utf-8 -*-
require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe Variant do
  
  before(:each) do        
    @product = create_product()    
    Spree::Config.set(:sample_default_weight => 1.0)
	end
  
  it "should not have a sample by default" do    
    @product.has_sample.should == false
  end
  
  it "should create a sample" do    
    default_weight = Spree::Config['sample_default_weight']
    default_weight.class.should == Float
    @product.has_sample = 'true'
    @product.save!
    @product.reload
    @product.variants.size.should == 1    
    @product.variants[0].is_sample.should == true    
    @product.variants[0].count_on_hand.should > 0
    @product.variants[0].weight.should == default_weight
  end
  
  it "should destroy sample" do
    @product.has_sample = 'true'
    @product.save!
    @product.reload
    @product.has_sample = 'false'
    @product.save!
    @product.reload
    @product.variants.size.should == 0
  end

end
