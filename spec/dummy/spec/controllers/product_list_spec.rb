# -*- encoding : utf-8 -*-
require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe ProductsController do
  
  before(:each) do
    @product = create_product(:with_sample => true)
	end
  
  it "should render list view" do
    get :index
    response.status.should == 200
  end
  
end
