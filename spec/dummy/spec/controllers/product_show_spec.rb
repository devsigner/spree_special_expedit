# -*- encoding : utf-8 -*-
require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe ProductsController do
  
  before(:each) do
    @product = create_product(:with_sample => true)
	end
  
  it "should render show view" do
    get :show, :id => @product.permalink
    response.status.should == 200
  end
  
end
